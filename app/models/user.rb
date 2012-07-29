class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password

  validates_presence_of :email, :on => :create
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => 'Looks like your email was invalid! Please try again'
  validates_uniqueness_of :email

  validates_presence_of :password, :on => :create
  validates_presence_of :password_confirmation, :on => :create
end
