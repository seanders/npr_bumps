# Spotify Config
SPOTIFY_CONFIG = YAML.load_file("#{Rails.root}/config/spotify.yml")[Rails.env]
