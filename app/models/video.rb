class Video < ActiveRecord::Base
  belongs_to :filmable
  attr_accessible :description, :link, :title, :type
end
