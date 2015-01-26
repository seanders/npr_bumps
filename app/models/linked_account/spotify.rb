# == Schema Information
#
# Table name: linked_accounts
#
#  id            :integer          not null, primary key
#  uid           :integer
#  person_id     :integer
#  type          :string(255)
#  email         :string(255)
#  name          :string(255)
#  image_url     :string(255)
#  oauth_token   :string(255)
#  refresh_token :string(255)
#  expires_at    :string(255)
#  expires_in    :integer
#  created_at    :datetime
#  updated_at    :datetime
#


# might need to require this explicitly, Beware:
# http://stackoverflow.com/questions/17695557/rails-organizing-models-in-subfolders-having-warning-toplevel-constant-a-refer
class LinkedAccount::Spotify < LinkedAccount

  # separate method from oauth_token. Dont mess with persistence logic.
  def valid_oauth_token
    return oauth_token if oauth_token_fresh?
    # get a new one and return it
    refresh_oauth_token!
    oauth_token
  end

  def oauth_token_fresh?(expiration_time = expiration_time)
    expiration_time > DateTime.now
  end

  def refresh_oauth_token!
    encoded_auth = Base64.strict_encode64("#{SPOTIFY_CONFIG['APP_ID']}:#{SPOTIFY_CONFIG['SECRET']}")
    request = { 
      :body => { "grant_type" => "refresh_token", "refresh_token" => refresh_token },
      :headers => { "Authorization" => "Basic #{encoded_auth}" }
    }
    response = request_new_oauth_token(request)
    update_attributes(:oauth_token => response["access_token"], :expires_at => (Time.now + response["expires_in"]).to_s)
  end

  private

  def expiration_time(expires_at = expires_at)
    Time.at(expires_at.to_i)
  end

  def request_new_oauth_token(request)
    HTTParty.post("https://accounts.spotify.com/api/token?refresh_token", request)
  end
end
