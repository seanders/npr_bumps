class SessionsController < ApplicationController

  def create
    #find or create using Spotify data
    # create access token for User to support FE API calls
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
