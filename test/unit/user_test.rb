require 'test_helper'

class UserTest < ActiveSupport::TestCase
	fixtures :users

	def setup
		@dmitry = users(:dmitry)
		@patrick = users(:patrick)
	end

  test "create user" do
    user = User.new(:email => "new_user@gmail.com", :password => "somepass", :password_confirmation => "somepass")

	  assert_not_nil :user
	 	assert user.save
	end

	test "attempt save user with invalid information" do
		#no-matching passwords
		user = User.new(:email => "new_user@gmail.com", :password => "new_pass", :password_confirmation => "different_pass")
	  assert !user.valid?, "User should fail validation if password and password confirmation do not match."

	  #non-unique email
	  user = User.new(:email => "dkolobov@gmail.com", :password => "new_pass", :password_confirmation => "new_pass")
	  assert !user.valid?, "User should fail validation if the email is taken."

	  #malformed email
	  user = User.new(:email => "new_user@gmailcom", :password => "new_pass", :password_confirmation => "new_pass")
	  assert !user.valid?, "User should fail validation if the email is not a valid email."
	end

	test "roles" do
		user = User.new(:email => "new_user@gmail.com", :password=>"somepass", :password_confirmation => "somepass")
		user.roles = ["standard","admin"]
		assert user.save
		assert user.is? :standard
		assert user.is? :admin
	end
end
