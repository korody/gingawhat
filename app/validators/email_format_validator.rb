# encoding:   utf-8
class EmailFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless value =~ /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      object.errors[attribute] << (options[:message] || 'Este formato de e-mail tá esquisito!')
    end
  end
end