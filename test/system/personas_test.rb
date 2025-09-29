require "application_system_test_case"

class PersonasTest < ApplicationSystemTestCase
  setup do
    @admin_user = users(:admin)
    sign_in_as(@admin_user)
  end


  test "visiting the index" do
    visit personas_url
    assert_selector "h1", text: "Usuarios"
  end

  test "should create Persona" do
    visit personas_url
    click_on "Nuevo Usuario"

    fill_in "Nombre", with: "Test"
    fill_in "Apellido", with: "Persona"
    fill_in "Correo electrónico para la cuenta del usuario", with: "test.persona@example.com"
    click_on "Create Persona"

    assert_text "Persona was successfully created"
  end
end
