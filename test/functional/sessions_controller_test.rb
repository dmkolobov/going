require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  fixtures :users
  
  def setup
    @dmitry = users(:dmitry)
    @controller = SessionsController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
    @request.host = "localhost"
  end

  test "user should login with correct credentials" do
    get :new
    assert_response :success

    post :create, {:email=>@dmitry.email, :password=>"wazzup"}
    assert_redirected_to root_url

    assert_equal @dmitry.id, session[:user_id]
  end

  test "user should logout" do
    get :destroy
    assert_redirected_to root_url
    assert_nil session[:user_id]
  end

  test "user should not be logged in if provided the wrong credentials" do
    post :create, {:email=>@dmitry.email, :password=>"wrong_pass"}
    assert_nil session[:user_id]
    assert_template :new

    post :create, {:email=>"wrong_email@gmail.com", :password=>"wrong_pass"}
    assert_nil session[:user_id]  
    assert_template :new
  end
end
