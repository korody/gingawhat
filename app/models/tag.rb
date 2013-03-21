class Tag < ActiveRecord::Base
  attr_accessible :name

  has_many :taggings
  has_many :posts, through: :taggings, source: :taggable, source_type: 'Post'

end
