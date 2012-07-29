require 'test_helper'

class UsersControllerTest < ActionController::TestCase
 	fixtures :users
  
  def setup
    @user_one = users(:user_one)
    @controller = UsersController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    @request.host = "localhost"
  end

  test "create user" do
  	post :create, {:user=>{:email=>'new_user@gmail.com', :password=>"password", :password_confirmation=>"password"}}
  	assert_not_nil session[:user_id]
  	assert_redirected_to root_url
  end

   test "attempt to create a new user with unmatching passwords" do
  	post :create, {:user=>{:email=>'new_user@gmail.com', :password=>"password", :password_confirmation=>"different_pass"}}
  	assert_nil session[:user_id]

  end

  test "attempt to create new user with a taken email" do
  	post :create, {:user=>{:email=>'some_user@gmail.com', :password=>"password", :password_confirmation=>"password"}}
  	assert_nil session[:user_id]
  end

  test "change password" do
  	session[:user_id] = @user_one.id

  	put :update, {:id=>session[:user_id], :user=>{:email=>"some_user@gmail.com", :password=>"new_pass", :password_confirmation=>"new_pass"}}
  	assert_response :found
  end


  test "change email" do
  	session[:user_id] = @user_one.id
  	
  	put :update, {:id=>session[:user_id], :user=>{:email=>"new_email@gmail.com", :password=>"wazzup", :password_confirmation=>"wazzup"}}
  	assert_response :found
  end
end
