class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to '/session/new'
    end
  end

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by_token(session[:token])
  end

end
