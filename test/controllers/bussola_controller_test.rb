require 'test_helper'

class BussolaControllerTest < ActionController::TestCase
  test "should get city" do
    get :city
    assert_response :success
  end

  test "should get neighborhood" do
    get :neighborhood
    assert_response :success
  end

end
