require 'test_helper'

class PortfolioControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get upload" do
    get :upload
    assert_response :success
  end

  test "should get upload_detail" do
    get :upload_detail
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
