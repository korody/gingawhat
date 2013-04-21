class User < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :bio, :email, :facebook, :instagram, :name, :title, :password, :password_confirmation, :social, :twitter, :type, :website, :attachments_attributes

  validates :email, presence: true, length: { maximum: 60 }, email_format: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { minimum: 2, maximum: 32 }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  before_save { self.email.downcase! }
  before_save { self.remember_token = SecureRandom.urlsafe_base64 }

  has_many :posts
  has_many :attachments, as: :attachable, dependent: :destroy

  accepts_nested_attributes_for :attachments

  TYPES = %w[Idealizadores Colaboradores Participantes Parceiros]
  validates :type, presence: true, inclusion: { in: TYPES }

  def send_password_reset
    self.password_reset_token = SecureRandom.urlsafe_base64
    self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
    UserMailer.password_reset(self).deliver
  end

  def self.types
    TYPES
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

end

class Idealizadores < User
end

class Colaboradores < User
end

class Participantes < User
end

class Parceiros < User
end


