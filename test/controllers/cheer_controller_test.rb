require "test_helper"

class CheerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cheer_index_url
    assert_response :success
  end
end
