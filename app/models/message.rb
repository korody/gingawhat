class Message
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  attr_accessor :name, :email, :phone, :assunto, :mensagem

  validates :mensagem, :name, :email, presence: true
  validates :email, format: { with: %r{.+@.+\..+} }, allow_blank: true
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end
