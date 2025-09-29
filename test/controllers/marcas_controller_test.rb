require "test_helper"

class MarcasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = users(:admin)
    @regular_user = users(:regular)
    @marca = marcas(:apple)
  end

  test "admin can get marcas index" do
    login_as(@admin_user)
    get marcas_url
    assert_response :success
  end

  test "admin can create a marca" do
    login_as(@admin_user)
    assert_difference("Marca.count", 1) do
      post marcas_url, params: { marca: { nombre: "Nueva Marca Test" } }
    end
    assert_redirected_to marca_url(Marca.last)
  end

  test "admin can destroy a marca" do
    login_as(@admin_user)
    marca_a_borrar = Marca.create!(nombre: "Para Borrar")
    assert_difference("Marca.count", -1) do
      delete marca_url(marca_a_borrar)
    end
    assert_redirected_to marcas_url
  end


  test "regular user is redirected from marcas index" do
    login_as(@regular_user)
    get marcas_url
    assert_redirected_to root_url
  end

  test "regular user cannot create a marca" do
    login_as(@regular_user)
    assert_no_difference("Marca.count") do
      post marcas_url, params: { marca: { nombre: "Marca Fallida" } }
    end
    assert_redirected_to root_url
  end
end