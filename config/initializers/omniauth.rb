Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, SPOTIFY_CONFIG['APP_ID'], SPOTIFY_CONFIG['SECRET'], scope: 'playlist-modify-public user-library-read user-read-private user-read-email'
end
