class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params.require(:user).permit(:username, :email, :password))
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Postit!"
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def show

  end

  def edit
    
  end
  
  def update
    if @user.update(params.require(:user).permit(:username, :email, :password))
      flash[:notice] = "Your profile was updated"
      redirect_to posts_path
    else
      render "edit"
    end
  end

private
  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:error] = "you cannot do that!"
      redirect_to posts_path
    end
  end
end