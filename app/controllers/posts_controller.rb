class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @user = current_user
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user != current_user
      flash[:alert] = "Only author of this post may edit it."
      redirect_to post_path(@post)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params.merge(user: current_user))
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:id])
    if @post == current_user
      @post.update(post_params)
    else
      flash[:alert] = "Only author of this post may edit it."
    end
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

end
