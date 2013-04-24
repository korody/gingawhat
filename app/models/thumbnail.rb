class Thumbnail < ActiveRecord::Base
  attr_accessible :thumb

  belongs_to :thumbable, polymorphic: true

  mount_uploader :thumb, ThumbUploader

end

