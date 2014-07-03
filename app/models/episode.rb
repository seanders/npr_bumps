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
    tracks_attributes_array = parse_tracks_data_from_html(html)
    tracks_attributes_array.each { |attributes| create_tracks_from_attributes(attributes) }
  end

  def create_tracks_from_attributes(attrs=nil)
    #TODO: Return NULL ojbects to handle no data coming back.
    # Wrap in transaction block to prevent shit tonnes of potentially bad data
    artist = Artist.where(name: attrs[:artist_name]).first_or_create
    album = artist.albums.where(name: attrs[:album_name], label: attrs[:label_name]).first_or_create if artist
    track = Track.create_with(album_id: album.id).where(
      title: attrs[:track_title],
      artist_id: artist.id
    ).first_or_create!
    # Prevents duplicate associatons b/n an episode and a track (i.e. same song occuring in episode multiple times)
    tracks << track if track && !tracks.include?(track)
  end

  def parse_tracks_data_from_html(html)
    Nokogiri::HTML(html).css(".musicwrap").map do |musicwrap_node|
      meta_node  = musicwrap_node.css("ol.mi-meta")
      track_title = get_info_from_meta_node('Track', meta_node)
      artist_name = get_info_from_meta_node('Artist', meta_node)
      album_name  = get_info_from_meta_node('Album', meta_node)
      label_name  = get_info_from_meta_node('Label', meta_node)
      # come back to add album information here
      {
        track_title: track_title,
        artist_name: artist_name,
        album_name:  album_name,
        label_name:  label_name
      }
    end
  end

  def update_date_from_html(html)
    date = parse_date_from_html(html)
    update_attribute(:date, date)
  end

  def parse_date_from_html(html)
    date = Nokogiri::HTML(html).css("meta[name=date]").attribute("content").value
    DateTime.parse(date)
  end

  private

  def get_info_from_meta_node(term_type, node)
    #   <dt>Artist</dt>
    #   <dd>Curumin</dd>
    term_node = node.search("dt:contains('#{term_type}')")
    # No data
    return nil if term_node.empty?
    get_description(term_node)
  end

  def get_description(term_node)
    result = term_node.first.next_element.inner_text.strip
    # Sometimes the markup might have an empty <dd>
    result.empty? ? nil : result
  end

end


# <ol class="mi-meta">
#   <dt>Artist</dt>
#   <dd>Curumin</dd>
#   <dt>Track</dt>
#   <dd>Blimblim</dd>
#   <dt>Album</dt>
#   <dd>Arrocha!</dd>
#   <dt>Label</dt>
#   <dd>Six Degrees</dd>
# </ol>
