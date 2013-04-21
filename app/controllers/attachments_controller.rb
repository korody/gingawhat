class AttachmentsController < ApplicationController
    
  # before_filter :what_job
  before_filter :authenticate, except: [:index, :show]
  
  def index
    @attachments = Attachment.where("attachable_id = ?", what_job)
  end


  def show
    @attachment = Attachment.find(params[:id])
  end


  def new
    @attachment = Attachment.new
  end


  def create
    @attachment = @job.attachments.create(params[:attachment])
  end


  def destroy
    Attachment.find(params[:id]).destroy
    redirect_to :back
  end

  private 

    # def what_job
    #   @job = Job.find(params["job_id"])
    # end
end
