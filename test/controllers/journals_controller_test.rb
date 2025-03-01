require "test_helper"

class JournalsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get journals_show_url
    assert_response :success
  end

  test "should get create" do
    get journals_create_url
    assert_response :success
  end
end
