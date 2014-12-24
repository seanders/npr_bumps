class Api::BaseController < ActionController::Base
  protect_from_forgery with: :null_session

  def require_person
    @person ||= Person.find(params[:person_id] || session[:person_id])
  end

  def require_auth
    render json: { error: 'Unauthorized user'}, status: :unauthorized unless authenticated?
  end

  def authenticated?
    @person.id == session[:person_id]
  end

  protected

  def verified_request?
    form_authenticity_token == request.headers['XSRF-TOKEN']
  end

  def handle_unverified_request
    super
    render json: { error: 'Invalid token'}, status: :unauthorized
  end
end
