# encoding: utf-8
class User < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :bio, :email, :facebook, :instagram, :name, :title, :password, :password_confirmation, :social, :twitter, :type, :website, :attachments_attributes, :videos_attributes, :from_city

  attr_accessor :from_city

  belongs_to :city

  validates :email, presence: true, length: { maximum: 60 }, email_format: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { minimum: 2, maximum: 32 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  before_save { self.email.downcase! }
  before_save { self.remember_token = SecureRandom.urlsafe_base64 }
  before_save :assign_city

  has_many :posts
  has_many :videos, as: :filmable
  has_many :attachments, as: :attachable, dependent: :destroy

  accepts_nested_attributes_for :attachments, :videos

  TYPES = %w[Idealizadores Colaboradores Participantes Parceiros]
  CITIES = [nil, "Rio de Janeiro", "São Paulo", "Fortaleza", "Salvador", "Recife", "Natal", "Cuiabá", "Manaus", "Porto Alegre", "Belo Horizonte", "Curitiba", "Brasília"]

  validates :type, presence: true, inclusion: { in: TYPES }

  scope :next, lambda {|id| where("id > ?",id).order("id ASC") } # this is the default ordering for AR
  scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }

  def next
    User.next(self.id).first
  end

  def previous
    User.previous(self.id).first
  end

  def send_password_reset
    self.password_reset_token = SecureRandom.urlsafe_base64
    self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
    UserMailer.password_reset(self).deliver
  end

  def self.types
    TYPES
  end

  def self.cities
    CITIES
  end

  def self.filter(params)
    if params[:city]
      User.where(city_id: params[:city])
    elsif params[:type]
      User.where(type: params[:type])
    else
      User.scoped
    end
  end

  def assign_city
    if !from_city.empty?
      some_city = City.where(name: from_city).first_or_create!
      self.city_id = some_city ? some_city.id : 0
    end
  end

end

class Idealizadores < User
end

class Colaboradores < User
end

class Participantes < User
end

class Parceiros < User
end


