require "application_system_test_case"

class ModelosTest < ApplicationSystemTestCase
  setup do
    @admin_user = users(:admin)
    sign_in_as(@admin_user)
  end

  test "visiting the index as admin" do
    visit modelos_url
    assert_selector "h1", text: "Modelos"
  end
end