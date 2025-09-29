require "test_helper"

class ArticulosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @regular_user = users(:regular)
    @regular_user_article = articulos(:one)
    @admin_article = articulos(:two)   
  end

  test "unauthenticated user is redirected from index" do
    get articulos_url
    assert_redirected_to new_session_url
  end

  test "regular user sees only their own articles on index" do
    login_as(@regular_user)
    get articulos_url
    assert_response :success
    assert_select "td", text: @regular_user.persona.nombre_completo, count: 1
    assert_select "td", text: @admin.persona.nombre_completo, count: 0
  end

  test "regular user can show their own article" do
    login_as(@regular_user)
    get articulo_url(@regular_user_article)
    assert_response :success
  end

  test "regular user is redirected when trying to see another's article" do
    login_as(@regular_user)
    get articulo_url(@admin_article)
    assert_redirected_to root_url 
  end

  test "regular user is redirected from new article page" do
    login_as(@regular_user)
    get new_articulo_url
    assert_redirected_to root_url
  end

  test "regular user cannot create an article" do
    login_as(@regular_user)
    assert_no_difference("Articulo.count") do
      post articulos_url, params: { articulo: { fecha_ingreso: Date.today, modelo_id: modelos(:macbook).id } }
    end
    assert_redirected_to root_url
  end

  test "regular user cannot destroy an article" do
    login_as(@regular_user)
    assert_no_difference("Articulo.count") do
      delete articulo_url(@regular_user_article)
    end
    assert_redirected_to root_url
  end


  test "admin sees all articles on index" do
    login_as(@admin)
    get articulos_url
    assert_response :success
    assert_select "td", text: @regular_user.persona.nombre_completo, count: 1
    assert_select "td", text: @admin.persona.nombre_completo, count: 1
  end

  test "admin can get new article page" do
    login_as(@admin)
    get new_articulo_url
    assert_response :success
  end

  test "admin can create an article" do
    login_as(@admin)
    assert_difference("Articulo.count", 1) do
      post articulos_url, params: { articulo: { fecha_ingreso: Date.today, modelo_id: modelos(:macbook).id, persona_id: personas(:one).id } }
    end
    assert_redirected_to articulo_url(Articulo.last)
  end

  test "admin can destroy any article" do
    login_as(@admin)
    assert_difference("Articulo.count", -1) do
      delete articulo_url(@regular_user_article)
    end
    assert_redirected_to articulos_url
  end
end