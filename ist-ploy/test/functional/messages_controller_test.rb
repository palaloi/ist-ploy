require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get compose" do
    get :compose
    assert_response :success
  end

  test "should get sent" do
    get :sent
    assert_response :success
  end

end
