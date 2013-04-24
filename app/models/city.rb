class City < ActiveRecord::Base
  attr_accessible :description, :name, :attachments_attributes, :videos_attributes

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :videos, as: :filmable

  accepts_nested_attributes_for :attachments, :videos

end
