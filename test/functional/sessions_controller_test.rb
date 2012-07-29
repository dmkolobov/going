require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  fixtures :users
  
  def setup
    @user_one = users(:user_one)
    @controller = SessionsController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    @request.host = "localhost"
  end

  test "user should login with correct credentials" do
    get :new
    assert_response :success

    post :create, {:user=>{:email=>"some_user@gmail.com", :password=>"wazzup"}}
    assert_redirected_to root_url

    assert_equal @user_one.id, session[:user_id]
  end

  test "user should logout" do
    get :destroy
    assert_redirected_to root_url
    assert_nil session[:user_id]
  end

  test "user should not be logged in if provided the wrong credentials" do
    post :create, {:user=>{:email=>"some_user@gmail.com", :password=>"wrong_pass"}}
    assert_nil session[:user_id]

    post :create, {:user=>{:email=>"some_user@gmail.com", :password=>"wrong_pass"}}
    assert_nil session[:user_id]  
  end
end
