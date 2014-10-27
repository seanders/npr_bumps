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
    Spotify::Client.new(access_token: @person.spotify_oauth_token).user_playlists(@person.spotify_id)
  end

end
