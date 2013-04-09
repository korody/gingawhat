class PostsController < ApplicationController
  
  def index
    @all_posts = Post.scoped
    @posts = Post.filter(params).order('posts.created_at DESC').paginate(page: params[:page], per_page: 20)
    @posts_by_month = @posts.group_by { |post| post.created_at.beginning_of_month }
    @cities = City.scoped
    @city = City.find(params[:city]) if params[:city]
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
