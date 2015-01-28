=begin
TODO: Build generic APIClient class for getting users playlists
so they can all have a similar interface
=end
class SendSongsToPlaylists
  extend Callable

  attr_reader :person, :type

  def initialize(person, type=Spotify::Client)
    @person = person
    @type = type
  end

  def call
    # get programs that are subscribed to.
    # get episodes for current day
    # get songs for those episodes
    # send those songs to the users playlists
  end

  def songs_to_send_to_playlist
    subscribed_playlists = @person.playlists.subscribed
    subscribed_playlists.each do |playlist|
      get_songs_for_playlist(playlist)
    end
  end

  def get_songs_for_playlist(playlist)
    # change to between later on
    playlist.subscriptions.includes(episodes: :tracks).where('episodes.date BETWEEN ? and ?', start_of_day, end_of_day).references(:episodes)
  end

  private

  # WE ARE ALWAYS SYNCING THE PREVIOUS DAYS TRACKS
  def start_of_day
    1.day.ago.beginning_of_day
  end

  def end_of_day
    1.day.ago.end_of_day
  end

end
