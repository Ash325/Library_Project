require "test_helper"

class Api::V1ControllerTest < ActionDispatch::IntegrationTest
  test "should get Libraries" do
    get api_v1_Libraries_url
    assert_response :success
  end
end
