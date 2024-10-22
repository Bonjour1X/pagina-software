require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(email: "user@example.com", password: "securepassword", name: "Test User", tipo: "Estudiante", phone: "0987654321")
  end

  test "should log in user with valid credentials" do
    post user_session_path, params: { user: { email: @user.email, password: "securepassword" } }
    
    assert_redirected_to root_url  # Asegúrate de que redirige a la página principal
    follow_redirect!
    assert_select "p", "Signed in successfully."  # Verifica el mensaje de Devise
  end

  test "should not log in user with invalid credentials" do
    post user_session_path, params: { user: { email: "wrong@example.com", password: "wrongpassword" } }
    
    assert_template 'devise/sessions/new'  # Verifica que se muestre el formulario de inicio de sesión
    assert_select "div#error_explanation"  # Verifica que se muestre el contenedor de errores
    assert_select "div.alert.alert-danger"  # Verifica que se muestre el contenedor de alertas
    assert_select "li", "Invalid email or password."  # Ajusta según el mensaje que estés utilizando
  end
end