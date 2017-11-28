class CommentsController < ApplicationController

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params.merge(user: current_user))
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.user != current_user
      flash[:alert] = "Only the author of the comment or post may edit."
      redirect_to post_path(@post)
    end
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      @comment.update(comment_params)
    else
      flash[:alert] = "Only the author of the comment or post may edit."
      redirect_to post_path(@post)
    end
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
