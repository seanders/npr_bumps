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
  # Validations
  validates :npr_id, presence: true
  validates :program_id, presence: true
  validates_uniqueness_of :npr_id, scope: :program_id

  # Relations
  belongs_to :program
  has_many :episode_track_relations
  has_many :tracks, through: :episode_track_relations

  def html_path
    "/programs/#{program.slug}/#{npr_id}"
  end

  def sync_songs(html)
    song_attributes_array = parse_song_data_from_html(html)
    song_attributes_array.each do |attributes|
      # find of create tracks here!
    end
  end

  def parse_song_data_from_html(html)
    Nokogiri::HTML(html).css(".musicwrap").map do |musicwrap_node|
      music_node  = musicwrap_node.css("ol.mi-meta")
      track_title = get_info_from_meta_node('Track', music_node)
      artist_name = get_info_from_meta_node('Artist', music_node)
      album_name  = get_info_from_meta_node('Album', music_node)
      label_name  = get_info_from_meta_node('Label', music_node)
      # come back to add album information here
      {
        track_title: track_title.try(:strip),
        artist_name: artist_name.strip,
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

  def get_info_from_meta_node(inner_html, node)
    element = node.search("dt:contains('#{inner_html}')")
    # No data
    return nil if element.empty?
    node.search("dt:contains('#{inner_html}')").first.next_element.inner_text
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
