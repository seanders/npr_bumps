source 'https://rubygems.org'
ruby "2.1.1"

require 'net/http'
require 'net/https'
require 'uri'

gem 'rails', '4.0.4'
gem 'pg'
gem 'unicorn'
gem 'nokogiri'
gem 'httparty'
gem 'em-http-request'
gem 'jbuilder'
# gem 'sidekiq'
gem 'npr'
gem 'omniauth-spotify'
gem 'spotify-client'
gem 'haml'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

group :development, :test do
  gem 'zeus'
  gem 'foreman'
  gem 'factory_girl_rails'
  gem 'rdoc'
  gem 'rspec-rails'
  gem 'sql-logging'
  gem 'pry'
  gem 'annotate'
  gem 'hirb'
end
