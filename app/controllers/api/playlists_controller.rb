class Api::PlaylistsController < Api::BaseController

  before_filter :require_person
  before_filter :require_auth
  before_filter :require_playlist

  def sync
    playlists = GetUserPlaylists.call(@person)
    @person.batch_create_playlists(playlists)
    render json: @person.playlists.to_json
  end

  def index
    @playlists = @person.playlists
    respond_to do |format|
      format.json { render json: @playlists }
    end
  end

  def show
    # manage subscriptions for a specific playlist
    @playlist
  end

  def subscriptions
    # all programs join attribute for is_subscribed
    @subscriptions = Program.subscriptions_for_playlist(params[:id])
  end

  def update_subscriptions
    if(@playlist.update_subscriptions(params[:program_ids]))
      @subscriptions = Program.subscriptions_for_playlist(@playlist.id)
      render 'subscriptions'
    else
      render json: @playlists.errors.full_messages.to_sentence, status: :unprocessable_entity
    end
  end

  private

  def require_playlist
    @playlist = Playlist.find(params[:id])
  end


end
