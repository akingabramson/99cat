class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    if params[:user][:username]
      user = User.find_by_username(params[:user][:username])
      if user.password == params[:user][:password]
        session[:token] = user.reset_session_token
        redirect_to "/cats"
      else
        redirect_to '/session/new'
      end
    else
      redirect_to '/session/new'
    end
  end
end


