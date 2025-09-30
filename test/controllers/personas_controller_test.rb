require "test_helper"

class PersonasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = users(:admin)
    @regular_user = users(:regular)
  end


  test "admin can get personas index" do
    login_as(@admin_user)
    get personas_url
    assert_response :success
  end


  test "regular user is redirected from personas index" do
    login_as(@regular_user)
    get personas_url
    assert_redirected_to root_url
  end
end
