class ShowSongScaffold
  attr_reader :show, :raw_html, :song_attributes_array

  def initialize(show, raw_html)
    @show = show
    @raw_html = raw_html
    @song_attributes_array = Show.parse_raw_html(raw_html)
  end

  def create_tracks_from_attributes
    # iterate through every song we scraped from this shows page
    @song_attributes_array.each do |song_attribute_hash|
       track = Track.where(
          title: song_attribute_hash[:track_title],
          artist: Artist.where(name: song_attribute_hash[:artist_name]).first_or_create
        ).first_or_create
        ShowTrackRelation.create(track_id: track.id, show_id: show.id)
    end
  end

  # need to loop through each show object and create Tracks and ShowTracks

end
