class SessionsController < ApplicationController

  def create
    @person = Person.find_or_create_from_oauth(auth_hash)
    #find or create using Spotify data
    # create access token for User to support FE API calls
  end

  private

  def auth_hash
    @auth_hash ||= AuthHash.new(request.env['omniauth.auth'])
  end
end
