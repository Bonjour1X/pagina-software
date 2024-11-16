require 'test_helper'

class RenderControllerTest < ActionDispatch::IntegrationTest

  test 'should get index' do
    get render_index_url
    assert_response :success
  end

  test "should get ajustes" do
    get render_ajustes_url
    assert_response :success
  end

  test "should get perfil" do
    user = users(:user_one)
    sign_in user       # Autentica al usuario con Devise
    get render_perfil_url
    assert_response :success
  end

  test "display_title for admin user" do
    user = users(:user_one)
    user.update(email: "admin@admin.com") # Define el email del admin en el fixture
    assert_equal "#{user.name} ★ Administrador Estrella ★", user.display_title
  end
  
  test "display_title for regular user" do
    user = users(:user_one)
    user.update(tipo: "Estudiante")
    assert_equal "Estudiante: #{user.name}", user.display_title
  end  
end