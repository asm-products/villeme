require 'test_helper'

class ProfileControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get events" do
    get :events
    assert_response :success
  end

  test "should get places" do
    get :places
    assert_response :success
  end

end
