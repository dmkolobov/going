require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "create user" do
    user = User.new(:email => "some_user@gmail.com", :password => "somepass", :password_confirmation => "somepass")

	  assert_not_nil :user
	 	assert user.save
	end

	test "user will not save if passwords don't match" do
		user = User.new(:email => "some_user@gmail.com", :password => "somepass", :password_confirmation => "otherpass")

	  assert_not_nil :user
	 	assert !user.save
	end
end
