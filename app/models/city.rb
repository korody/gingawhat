class City < ActiveRecord::Base
  attr_accessible :description, :name, :attachments_attributes, :videos_attributes

  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :videos, as: :filmable

  accepts_nested_attributes_for :attachments, :videos

  scope :next, lambda {|id| where("id > ?",id).order("id ASC") } # this is the default ordering for AR
  scope :previous, lambda {|id| where("id < ?",id).order("id DESC") }

  def next
    City.next(self.id).first
  end

  def previous
    City.previous(self.id).first
  end

end
