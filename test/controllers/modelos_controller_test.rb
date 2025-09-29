require "test_helper"

class ModelosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = users(:admin)
    @regular_user = users(:regular)
    @modelo = modelos(:macbook)
  end


  test "admin can get modelos index" do
    login_as(@admin_user)
    get modelos_url
    assert_response :success
  end

  test "admin can create a modelo" do
    login_as(@admin_user)
    assert_difference("Modelo.count", 1) do
      post modelos_url, params: { modelo: { nombre: "Nuevo Modelo Test", marca_id: marcas(:apple).id } }
    end
    assert_redirected_to modelo_url(Modelo.last)
  end

  test "admin can destroy a modelo" do
    login_as(@admin_user)
    modelo_a_borrar = Modelo.create!(nombre: "Para Borrar", marca: marcas(:dell))
    modelo_a_borrar.articulos.destroy_all 
    assert_difference("Modelo.count", -1) do
      delete modelo_url(modelo_a_borrar)
    end
    assert_redirected_to modelos_url
  end


  test "regular user is redirected from modelos index" do
    login_as(@regular_user)
    get modelos_url
    assert_redirected_to root_url
  end

  test "regular user cannot create a modelo" do
    login_as(@regular_user)
    assert_no_difference("Modelo.count") do
      post modelos_url, params: { modelo: { nombre: "Modelo Fallido", marca_id: marcas(:apple).id } }
    end
    assert_redirected_to root_url
  end
end