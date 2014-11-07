class PersonController < ApplicationController

  before_filter :require_person
  before_filter :require_auth, only: [:show]

  def show
    @playlists = @person.playlists
  end

  private

  def require_auth
    redirect_to :root unless authenticated?
  end

end
