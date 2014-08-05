class SpotifyTrackSyncer
  # attr_reader :spotify_client
  include Singleton

  def sync_track(track)
    # take track object, and search Spotify API for data
    search_params = build_track_search_params(track)
    # parse results for best match
    api_response = spotify_client.search(:track, search_params)
    spotify_and_external_ids = parse_external_ids_from_api_response(api_response)
    track.update_attributes(spotify_and_external_ids)
  end

  def spotify_client
    # load the config; perhaps from a yml file
    @spotify_client ||= Spotify::Client.new()
  end

  def parse_external_ids_from_api_response(api_response)
    # For now, we are going to assume the first Spotify search result is the best match
    # for a particular track
    track_object = api_response['tracks']['items'].first
    {spotify_id: track_object['id'], external_ids: track_object['external_ids']}
  end

  private

  def build_track_search_params(track)
    query = "track:'#{track.name}'"
    query += " artist:'#{track.artist.name}'" if track.artist
    query += " album:'#{track.album.name}'" if track.album
  end
end
