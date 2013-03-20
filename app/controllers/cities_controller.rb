class CitiesController < ApplicationController
  def index
    @cities = City.scoped
  end

  def show
    @city = City.find(params[:id])
  end

  def new
    @city = City.new
  end

  def create
    @city = City.create(params[:city])
  end

  def edit
    @city = City.find(params[:id])
  end

  def update
    @city = City.find(params[:id])
    @city.update_attributes!(params[:city])
    redirect_to @city
  end

  def destroy
    City.find(params[:id]).destroy
    redirect_to :back
  end

end
