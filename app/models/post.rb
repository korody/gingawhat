# encoding: utf-8
class Post < ActiveRecord::Base
  attr_accessible :content, :title, :user_id, :tag_list, :city_id, :from_city, :attachments_attributes, :videos_attributes

  attr_accessor :from_city

  belongs_to :city
  belongs_to :user

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :taggings, as: :taggable
  has_many :videos, as: :filmable
  has_many :tags, through: :taggings

  validates :user_id, presence: true

  before_save :assign_city

  accepts_nested_attributes_for :attachments, :videos

  CITIES = [nil, "Rio de Janeiro", "São Paulo", "Fortaleza", "Salvador", "Recife", "Natal", "Cuiabá", "Manaus", "Porto Alegre", "Belo Horizonte", "Curitiba", "Brasília"]

  scope :next, lambda {|id| where("id > ?",id).order("id ASC") } # this is the default ordering for AR
  scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }

  def next
    self.class.first(:conditions => ["title < ?", title], :order => "title desc")
  end

  def previous
    Post.previous(self.id).first
  end

  def self.cities
    CITIES
  end

  def self.filter(params)
    if params[:city]
      Post.where(city_id: params[:city])
    elsif params[:tag]
      Post.tagged_with(params[:tag])
    else
      Post.scoped
    end
  end

  def assign_city
    if !from_city.empty?
      some_city = City.where(name: from_city).first_or_create!
      self.city_id = some_city ? some_city.id : 0
    end
  end
    
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
