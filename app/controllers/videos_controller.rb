class VideosController < ApplicationController
  before_filter :authenticate, only: [:new, :create, :destroy, :edit]
  before_filter :authorized_user, only: [:edit, :update, :destroy]

  def index
    @videos = Video.filter(params).order('videos.created_at ASC').paginate(page: params[:page], per_page: 20)
    @videos_by_type = @videos.group_by { |v| v.type }
    @cities = City.scoped
    @city = City.find(params[:city]) if params[:city]
  end

  def show
    @video = Video.find(params[:id])
  end

  def new
    @video = Video.new
  end

  def create
    @user = current_user
    @video = @user.videos.create(params[:video])
    if @video.save
      redirect_to @video
    else
      render 'new'
    end  
  end

  def edit
    @video = Video.find(params[:id])

  end

  def update
    @video = Video.find(params[:id])
    @video.update_attributes!(params[:video])
    redirect_to @video
  end

  def destroy
    Video.find(params[:id]).destroy
    redirect_to @videos
  end

  private

    def authorized_user
      @video = current_user.videos.find_by_id(params[:id])
      redirect_to root_path, notice: "wrong way mate!" if @video.nil?
    end

end
