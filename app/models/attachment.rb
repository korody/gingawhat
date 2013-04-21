class Attachment < ActiveRecord::Base
  attr_accessible :description, :image
  
  belongs_to :attachable, polymorphic: true

  mount_uploader :image, FileUploader
end
