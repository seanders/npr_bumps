class AddSongWorker
  include Sidekiq::Worker

  def perform(person)
    # SEND SHIT TO PERSONs PLAYLIST
    SendSongsToPlaylists.call(person, Spotify::Client)
  end
end
