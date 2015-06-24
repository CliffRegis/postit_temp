class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @post = Post.find(params[:post_id])

    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user
    if @comment.save
      flash[:notice] = "Your comment was saved"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def show
  end

  def vote
    @comment = Comment.find(params[:id])
    @post = @comment.post(params[:id])
    @vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])

    if @vote.valid?
      flash[:notice]= "You voted"
      redirect_to post_path(@post)
    else
      flash[:error]= "Didn't work"
      redirect_to :back
    end
  end
 
end