require 'test_helper'

class FriendshipsControllerTest < ActionController::TestCase
  test "should get request" do
    get :request
    assert_response :success
  end

  test "should get accept" do
    get :accept
    assert_response :success
  end

end
