class Tagging < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :tag
  belongs_to :taggable, polymorphic: true

end
