require "application_system_test_case"

class MarcasTest < ApplicationSystemTestCase
  test "admin can visit the index" do
    sign_in_as(users(:admin)) # Inicia sesión como admin
    visit marcas_url          # Visita la página
    assert_selector "h1", text: "Marcas" # Verifica que la página cargó correctamente
  end
end
