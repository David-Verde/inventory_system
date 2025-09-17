require "test_helper"

class TransferenciasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    login_as(@user)
    @articulo = articulos(:one)
  end

  test "should get new" do
    get new_articulo_transferencia_url(@articulo)
    assert_response :success
  end
end
