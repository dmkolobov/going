require 'test_helper'

class UsersControllerTest < ActionController::TestCase
 	fixtures :users
  
  def setup
    @dmitry = users(:dmitry)
    @patrick = users(:patrick)

    @controller = UsersController.new
    @response = ActionController::TestResponse.new
    @request = ActionController::TestRequest.new
    @request.host = "localhost"
  end

  test "new user" do
    get :new 
    assert_response :success
    assert_template "new"
    assert_not_nil assigns["user"]
  end

  test "edit user" do
    session[:user_id] = @dmitry.id

    #user should be able to edit itself
    get :edit, :id => session[:user_id]
    assert_response :success
    assert_equal @dmitry.attributes, assigns["user"].attributes
  end

  test "show user" do
  	get :show, :id => @dmitry.id
  	assert_response :success
  	assert_equal @dmitry.attributes, assigns["user"].attributes
  end

  test "create user" do
    post :create, {:user=>{:email=>"new_user@gmail.com", :username=>"new_user_name", :password=>"new_pass",:password_confirmation=>"new_pass"}}
    assert_redirected_to root_url
    assert_not_nil session[:user_id], "New user was not logged in."
  end

  test "update user" do
    #log user in
    session[:user_id] = @dmitry.id

    put :update, {:id=>session[:user_id], :user=>{:email=>@dmitry.email, :password=>"new_pass",:password_confirmation=>"new_pass"}}
    assert_redirected_to user_path(@dmitry)
  end

  test "destroy user" do 
    session[:user_id] = @dmitry.id

    delete :destroy, {:id => session[:user_id], :password=>"wazzup", :password_confirmation=>"wazzup"}
    assert_redirected_to root_url
    assert_nil session[:user_id]
  end

  test "user should not be able to destroy another user" do
    session[:user_id] = @dmitry.id

    delete :destroy, {:id=> @patrick.id, :password=>"nope", :password_confirmation=>"nope"}
    assert_redirected_to root_url
  end

  test "user should not be able to change another user" do
    session[:user_id] = @dmitry.id

    put :update,  {:id=>@patrick.id, :user=>{:email=>@patrick.email, :password=>"hacked_pass", :password=>"hacked_pass"}}
    assert_redirected_to root_url
  end
end
