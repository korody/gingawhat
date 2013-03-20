class PostsController < ApplicationController
  def index
    @posts = Post.scoped
    @cities = City.scoped
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(params[:post])
    redirect_to @post
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes!(params[:post])
    redirect_to @post
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to @posts
  end

end
