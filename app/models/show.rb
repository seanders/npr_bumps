# == Schema Information
#
# Table name: shows
#
#  id         :integer          not null, primary key
#  date       :date
#  remote_id  :integer          not null
#  program_id :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Show < ActiveRecord::Base
  belongs_to :program
  has_many :show_track_relations
  has_many :tracks, through: :show_track_relations
  validates :remote_id, presence: true
  validates :program_id, presence: true
  validates_uniqueness_of :remote_id, scope: :program_id

  # Todo: Batch requesting is buggy because of async loaded archive pages. ie. You have to scroll to the bottom to get more songs to load
  # You can scrape show_id form the latest show page. If we hit the page everyday, we should always have the remote_id
  def remote_sync
    Show.batch_remote_sync([self])
  end

  def self.batch_remote_sync(shows)
    shows_paired_with_html_response = build_show_song_scaffolds(shows)
    #some class method on a new object that returns simple, iterate-able obejcts to simply track, artists, show_track creation
    show_scaffolds = shows_paired_with_html_response.map do |(show, raw_html)|
      Rails.logger.info("Parsing HTML for show_id: #{show.id}")
      ShowSongScaffold.new(show, raw_html)
    end

    show_scaffolds.each {|scaffold| scaffold.create_tracks_from_attributes }
  end

  def self.build_show_song_scaffolds(shows)
    html_objects = shows.map {|show| show.build_html_request_object }
    raw_html_responses = HTMLGetter.async_page_request(html_objects)
    shows.zip(raw_html_responses)
  end

  def build_html_request_object
    # http://www.npr.org/programs/all-things-considered/2014/01/31/269516522?showDate=2014-01-31
    HTMLGetter.new(program, "/#{date.to_param.gsub('-', '/')}/#{remote_id}", {showDate: date.strftime("%Y-%m-%d")})
  end

  def self.parse_raw_html(html)

  end
end
