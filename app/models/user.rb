class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password

  validates_presence_of :email, :on => :create
  validates_uniqueness_of :email
  validates_presence_of :password, :on => :create
  validates_presence_of :password_confirmation, :on => :create
end
