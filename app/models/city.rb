class City < ActiveRecord::Base
  attr_accessible :description, :name, :thumbnails_attributes

  has_many :thumbnails, as: :thumbable, dependent: :destroy

  accepts_nested_attributes_for :thumbnails

end
