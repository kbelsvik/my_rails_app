require 'test_helper'

class GreetingsControllerTest < ActionController::TestCase
  test "should get hello" do
    get :hello
    assert_response :success
  end

  test "should fail", :fail => true do
    fail
  end

end
