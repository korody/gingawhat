# encoding: utf-8
class Video < ActiveRecord::Base
  attr_accessible :description, :link, :title, :type, :at_city 
  attr_accessor :at_city

  belongs_to :city

  belongs_to :filmable, polymorphic: true

  validates :link, presence: true

  TYPES = %w[Teasers Episodios Pessoas Makingof]
  CITIES = [nil, "Rio de Janeiro", "São Paulo", "Fortaleza", "Salvador", "Recife", "Natal", "Cuiabá", "Manaus", "Porto Alegre", "Belo Horizonte", "Curitiba", "Brasília"]

  validates :type, presence: true, inclusion: { in: TYPES }
  # validates :city_id, presence: true, inclusion: { in: CITIES }
  # validates :user_id, presence: true

  before_save :assign_city, :normalize_link

  def normalize_link
    if link
      self.link = link.gsub("watch?v=", "embed/").gsub("http://www", "https://www")
    end  
  end

  def self.types
    TYPES
  end

  def self.cities
    CITIES
  end

  def self.filter(params)
    if params[:city]
      Video.where(city_id: params[:city])
    elsif params[:type]
      Video.where(type: params[:type])
    else
      Video.scoped
    end
  end

  def assign_city
    if !at_city.empty?
      # some_city = Client.find_or_create_by_name(from_city)
      some_city = City.where(name: at_city).first_or_create!
      self.city_id = some_city ? some_city.id : 0
      # self.client_id = some_city.client_id
    end
  end
end

class Episodios < Video
end

class Teasers < Video
end

class Pessoas < Video
end

class Makingof < Video
end