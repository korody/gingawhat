class TagsController < ApplicationController
    
  def destroy
    Tag.find(params[:id]).destroy
    redirect_to :back
  end

end
