class PostsController < ApplicationController
  def index
    if params[:tag]
        @posts = Post.tagged_with(params[:tag])
      else
        @posts = Post.scoped.order('posts.created_at DESC')
      end
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
