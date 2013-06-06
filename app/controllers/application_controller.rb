class ApplicationController < ActionController::Base
  protect_from_forgery

  def logged_in?
    if session[:token]
      @current_user = User.find_by_token(session[:token])
      if @current_user
        return true
      else
        return false
      end
    else
      return false
    end
  end    

end
