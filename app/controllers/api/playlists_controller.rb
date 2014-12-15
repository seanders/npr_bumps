class Api::PlaylistsController < Api::BaseController

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

  def index
    @playlists = @person.playlists
    respond_to do |format|
      format.json { render json: @playlists }
    end
  end


end
