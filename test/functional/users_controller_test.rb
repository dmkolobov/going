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
    get :edit, :id => @dmitry.id
    assert_response :success
    assert_template "edit"
    assert_not_nil assigns["user"]
    assert_equal @dmitry.attributes, assigns["user"].attributes
  end

  test "show user" do
  	get :show, :id => @dmitry.id
  	assert_response :success
  	assert_template "show"
  	assert_not_nil assigns["user"]
  	assert_equal @dmitry.attributes, assigns["user"].attributes
  end

  test "create user" do

  end

  test "update user" do

  end

  test "destroy user" do 

  end
end
