class PostsController < ApplicationController
  before_filter :authenticate, only: [:new, :create, :destroy, :edit]
  before_filter :authorized_user, only: [:edit, :update, :destroy]
  
  def index
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
    @user = current_user
    @post = @user.posts.create(params[:post])
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
    redirect_to blog_path
  end

  private

    def authorized_user
      @post = current_user.posts.find_by_id(params[:id])
      redirect_to root_path if @post.nil?
    end

end
