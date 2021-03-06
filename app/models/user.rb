class User < ActiveRecord::Base
	ROLES = %w[standard]

  attr_accessible :email, :password, :password_confirmation, :username
  has_secure_password

  validates_presence_of :email, :on => :create
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  validates_uniqueness_of :email

  validates_presence_of :password, :on => :create
  validates_presence_of :password_confirmation, :on => :create

  validates_presence_of :username

  before_create :assign_default_role

  def assign_default_role
    self.roles=["standard"]
  end

  def roles=(roles)    
    self.roles_mask = (roles & ROLES ).map {|r| 2**ROLES.index(r) }.sum
  end

  def roles
  	ROLES.reject do |r|
			((roles_mask || 0) & 2**ROLES.index(r)).zero?
  	end
  end

  def is?(role)
    roles.include?(role.to_s)
  end
end
