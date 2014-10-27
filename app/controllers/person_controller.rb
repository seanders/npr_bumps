class PersonController < ApplicationController

  before_filter :require_person

  def show
    @playlists = GetUserPlaylists.call(@person)['items']
  end

  private

  def require_auth
    redirect_to :root unless authenticated?
  end

end
