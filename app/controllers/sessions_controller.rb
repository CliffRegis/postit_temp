class SessionsController < ApplicationController

  def new

  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "Hello"
      redirect_to posts_path
    else
      flash[:notice]= "There's something wrong"
      redirect_to posts_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You are logged out"
    redirect_to posts_path
  end
end