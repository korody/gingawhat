class Post < ActiveRecord::Base
  attr_accessible :content, :title, :user_id, :tag_list

  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  def self.tagged_with(name)
    Tag.find_by_name!(name).posts
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.id) as count").
      joins(:taggings).group("tags.id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

end
