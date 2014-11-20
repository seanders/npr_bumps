class PlaylistsController < ApplicationController

  before_filter :require_person
  before_filter :require_auth

  def sync
    @playlists = GetUserPlaylists.call(@person)
    @person.batch_create_playlists(@playlists)
    redirect_to person_path(@person)
  end

  def show
    # manage subscriptions for a specific playlist
    @playlist = Playlist.find(params[:id])
  end


end
