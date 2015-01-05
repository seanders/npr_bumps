class Api::PlaylistsController < Api::BaseController

  before_filter :require_person
  before_filter :require_auth
  before_filter :require_playlist

  def sync
    playlists = GetUserPlaylists.call(@person)
    @person.batch_create_playlists(playlists)
    render json: @person.playlists.to_json
  end

  def show
    # manage subscriptions for a specific playlist
    @playlist
  end

  def subscriptions
    # all programs join attribute for is_subscribed
    @subscriptions = 
      Program.joins("LEFT JOIN playlist_program_relations ON playlist_program_relations.program_id = programs.id").
        select("programs.*, playlist_program_relations.id as is_subscribed").
        where("playlist_program_relations.playlist_id = ? OR playlist_program_relations.playlist_id IS NULL", params[:id])
  end

  def index
    @playlists = @person.playlists
    respond_to do |format|
      format.json { render json: @playlists }
    end
  end

  private

  def require_playlist
    @playlist = Playlist.find(params[:id])
  end


end
