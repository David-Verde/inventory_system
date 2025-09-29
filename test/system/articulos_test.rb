require "application_system_test_case"

class ArticulosTest < ApplicationSystemTestCase
  setup do
    @admin_user = users(:admin)
    sign_in_as(@admin_user)
  end

  test "visiting the index as admin" do
    visit articulos_url
    assert_selector "h1", text: "Artículos"
  end
end