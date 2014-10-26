class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def require_person
    @person ||= Person.find(params[:id])
  end


  def authenticated?
    @person.id == session[:id]
  end
end
