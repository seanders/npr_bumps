# == Schema Information
#
# Table name: episodes
#
#  id         :integer          not null, primary key
#  npr_id     :integer
#  date       :datetime
#  url        :string(255)
#  program_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Episode < ActiveRecord::Base
  validates :npr_id, presence: true
  validates :program_id, presence: true
  validates_uniqueness_of :npr_id, scope: :program_id

  belongs_to :program
  has_many :episode_track_relations
  has_many :tracks, through: :episode_track_relations

  def html_path
    "/programs/#{program.slug}/#{npr_id}"
  end

  def sync_tracks(html)
    tracks_attributes_array = HtmlParser.new.build_track_attributes_array_from_html(html)
    tracks_attributes_array.each { |attributes| create_tracks_from_attributes(attributes) }
  end

  def create_tracks_from_attributes(attrs=nil)
    #TODO: Return NULL ojbects to handle no data coming back.
    # Wrap in transaction block to prevent shit tonnes of potentially bad data
    # artist = Artist.where(name: attrs[:artist_name]).first_or_create if attrs[:artist_name]
    # album = artist.albums.where(name: attrs[:album_name], label: attrs[:label_name]).first_or_create if artist && attrs[:album_name]
    tracks.where("title = ? AND npr_attributes -> 'artist_name' = ? AND npr_attributes -> 'album_name' = ?",
      attrs[:track_title],
      attrs[:artist_name],
      attrs[:album_name]
    ).first_or_create!(title: attrs[:track_title], npr_attributes: {artist_name: attrs[:artist_name], album_name: attrs[:album_name]})
    # Prevents duplicate associatons b/n an episode and a track (i.e. same song occuring in episode multiple times)
    # tracks << track if track && !tracks.include?(track)
  end

  def update_date_from_html(html)
    date = parse_date_from_html(html)
    update_attribute(:date, date)
  end

  def parse_date_from_html(html)
    date = Nokogiri::HTML(html).css("meta[name=date]").attribute("content").value
    DateTime.parse(date)
  end

end
