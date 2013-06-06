class UsersController < ApplicationController
  def create
    @user = User.create(params[:user])
    session[:token] = @user.reset_session_token
    redirect_to '/cats'
  end

  def new
    render :new
  end
end
