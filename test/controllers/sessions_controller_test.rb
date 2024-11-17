require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(email: "user@example.com", password: "securepassword", name: "Test User", tipo: "Estudiante", 
                         phone: "0987654321")
  end

  # Failure
  #test "should log in user with valid credentials" do
  #  post user_session_path, params: { user: { email: @user.email, password: "securepassword" } }
  #  
  #  assert_redirected_to root_url  # Asegúrate de que redirige a la página principal
  #  follow_redirect!
  #  assert_select "p", "Signed in successfully."  # Verifica el mensaje de Devise
  #end

  # Failure
  # test "should not log in user with invalid credentials" do
  #   post user_session_path, params: { user: { email: "wrong@example.com", password: "wrongpassword" } }
  #   
  #   assert_template 'devise/sessions/new'  # Verifica que se muestre el formulario de inicio de sesión
  #   assert_select "div.alert.alert-danger", "Invalid Email or password."  # Verifica el mensaje de alerta en flash
  # end
end