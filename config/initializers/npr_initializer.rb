require 'yaml'

NPR.configure do |config|
  config.apiKey = YAML.load_file("#{Rails.root}/config/secrets.yml")[Rails.env]["npr_key"]
  config.output = "json"
end
