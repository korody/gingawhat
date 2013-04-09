class User < ActiveRecord::Base
  attr_accessible :bio, :facebook, :instagram, :name, :social, :twitter, :type, :website
end
