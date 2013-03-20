class ThumbnailsController < ApplicationController
    
  before_filter :what_city
  # before_filter :authenticate, except: [:index, :show]
  
  def index
    @thumbnails = Thumbnail.where("thumbable_id = ?", what_city)
  end

  def show
    @thumbnail = Thumbnail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json
    end
  end

  def new
    @thumbnail = Thumbnail.new
  end

  def create
    @thumbnail = @city.thumbnails.create(params[:thumbnail])
  end

  def destroy
    Thumbnail.find(params[:id]).destroy
    redirect_to :back
  end

  private 

    def what_city
      @city = City.find(params["city_id"])
    end
end
