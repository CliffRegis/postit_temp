class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only:[:edit, :update]
  
  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
    
  end
  
  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save(post_params)
      flash[:notice] = "Your post was saved"
      redirect_to posts_path
    else
      render "new"
    end
  end
  
  def edit
  end
  
  def update
       
    if @post.update(post_params)
      flash[:notice] = "Your post was updated"
      redirect_to post_path
    else
      render "edit"
    end
  end

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
      if @vote.valid?
        flash[:error] = "You voted!"
        redirect_to :back
      else
        flash[:notice] = "Something went wrong!"
        redirect_to root_path
      end
  end


  private

  def post_params # SO YOU CAN USE THE FIELD ON THE FORMS
    params.require(:post).permit(:url, :name, :body, :comment, :category, :creator, :username, :title, :description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def require_same_user
    @user = User.find(params[:id])
    if current_user != @user
      flash[:error] = "you cannot do that!"
      redirect_to posts_path
    end
  end
end
