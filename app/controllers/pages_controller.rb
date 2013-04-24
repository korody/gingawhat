class PagesController < ApplicationController
  
  def welcome
  end

  def home
    @attachment = Attachment.scoped
  end

end
