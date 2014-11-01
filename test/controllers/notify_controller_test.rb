require 'test_helper'

class NotifyControllerTest < ActionController::TestCase
  test "should get bell" do
    get :bell
    assert_response :success
  end

end
