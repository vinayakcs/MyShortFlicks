require 'test_helper'

class VideosControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get claim" do
    get :claim
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
