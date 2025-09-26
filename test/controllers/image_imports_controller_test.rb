require "test_helper"

class ImageImportsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get image_imports_create_url
    assert_response :success
  end
end
