class User < ActiveRecord::Base
	ROLES = %w[superadmin admin standard]

  attr_accessible :email, :password, :password_confirmation
  has_secure_password

  validates_presence_of :email, :on => :create
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => 'Looks like your email was invalid! Please try again'
  validates_uniqueness_of :email

  validates_presence_of :password, :on => :create
  validates_presence_of :password_confirmation, :on => :create

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
