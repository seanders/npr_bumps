=begin
TODO: Build generic APIClient class for getting users playlists
so they can all have a similar interface
=end
class GetUserPlaylists
  extend Callable

  attr_reader :person, :type

  def initialize(person, type=Spotify::Client)
    @person = person
    @type = type
  end

  def call
    playlist_response = fetch_playlists_for_person(@person)
    parse_playlists_array_from_response(playlist_response)
  end

  def fetch_playlists_for_person(person=@person)
    Spotify::Client.new(access_token: person.spotify_oauth_token, raise_errors: true).user_playlists(person.spotify_id)
  end

  def parse_playlists_array_from_response(raw_response)
    raw_response['items']
  end

end
