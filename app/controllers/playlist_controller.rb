class PlaylistController < ApplicationController

  before_filter :require_person

  def sync
    @playlists = GetUserPlaylists.call(@person)
    @person.batch_create_playlists(@playlists)
    redirect_to person_path(@person)
  end


end
