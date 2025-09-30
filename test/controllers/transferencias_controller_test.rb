require "test_helper"

class TransferenciasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = users(:admin)
    login_as(@admin_user)
    @articulo = articulos(:one)
    @nueva_persona = personas(:one)
  end

  test "admin should get new" do
    get new_articulo_transferencia_url(@articulo)
    assert_response :success
  end

  test "admin should create transferencia" do
    assert_difference "Transferencia.count" do
      post articulo_transferencias_url(@articulo), params: { transferencia: { persona_id: @nueva_persona.id } }
    end

    @articulo.reload
    assert_equal @nueva_persona.id, @articulo.persona_id
    assert_redirected_to articulo_url(@articulo)
  end
end
