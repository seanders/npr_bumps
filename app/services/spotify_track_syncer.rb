=begin
  Purpose: Take attributes from NPR that is stored in each tracks `npr_attributes`
  and build artists
=end

class SpotifyTrackSyncer
  # attr_reader :spotify_client

  def self.sync_track(track)
    # take track object, and search Spotify API for data
    search_params = build_track_search_params(track)
    # parse results for best match
    api_response = spotify_client.search(:track, search_params)

    # return if no matches
    if api_response['tracks']['total'].to_i == 0
      return track
    end

    spotify_and_external_ids = parse_external_ids_from_api_response(api_response)
    album_attrs = parse_album_attrs_from_api_response(api_response)
    track_artist_attrs_array = map_artist_attrs_from_api_response(api_response)
    # add artists to track_artist_relations
    artists = build_artists_from_attributes_array(track_artist_attrs_array)
    # guard clause, don't try to re-add artist if it already is on the track model
    return track unless (track.artists & artists).empty?
    track.artists << artists
    track.assign_attributes(spotify_and_external_ids)
    # if album already exists
    album = Album.find_or_create_by(album_attrs.merge(artist_id: track.artists.first.id))
    track.album = album
    # the first artist seems to be the primary artist for an album/track
    track.save!
  end

  def self.build_artists_from_attributes_array(artist_attrs_array)
    # find or create artist. If no artist attrs. return null Artist object
    artist_attrs_array.map { |artist_attrs| Artist.find_or_create_from_name(artist_attrs) }.compact
  end

  def self.batch_sync_tracks(tracks_array)
    EM.run {
      EM::Iterator.new(tracks_array, 5).each(
        proc { |track, iterator|
          EM.defer(
            proc { self.sync_track(track) },
            proc { |result| iterator.next }
          )
        },
        proc { |result| EM.stop }
      )
    }
  end

  def self.spotify_client
    # load the config; perhaps from a yml file
    @spotify_client ||= Spotify::Client.new()
  end

  def self.parse_external_ids_from_api_response(api_response)
    # For now, we are going to assume the first Spotify search result is the best match
    # for a particular track
    track_object = api_response['tracks']['items'].first
    {spotify_id: track_object['id'], external_ids: track_object['external_ids']}
  end

  def self.parse_album_attrs_from_api_response(api_response)
    album_object = api_response['tracks']['items'].first['album']
    {
      name:       album_object['name'],
      spotify_id: album_object['id'],
      image_url:  album_object['images'].first['url']
    }
  end

  def self.map_artist_attrs_from_api_response(api_response)
    artist_object = api_response['tracks']['items'].first['artists']
    artist_object.map {|artist| {name: artist['name']} }
  end

  private

  def self.build_track_search_params(track)
    query = "track:'#{track.title}'"
    query += " artist:'#{track.npr_attributes['artist_name']}'" if track.npr_attributes['artist_name']
    query += " album:'#{track.npr_attributes['album_name']}'" if track.npr_attributes['album_name']
    return query
  end
end
