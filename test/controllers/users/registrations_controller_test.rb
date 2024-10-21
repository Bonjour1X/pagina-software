require "test_helper"

class Users::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should create user" do
    assert_difference('User.count', 1) do
      post user_registration_path, params: {  
        user: {
          email: "new_user@example.com",  
          password: "securepassword",
          name: "New User",
          tipo: "Estudiante",
          phone: "0987654321"
        }
      }
    end

    assert_redirected_to root_url  
    follow_redirect!
    assert_select "p", "Welcome! You have signed up successfully."  
  end

  test "should not create user without email" do
    assert_no_difference('User.count') do
      post user_registration_path, params: {
        user: {
          email: "",  # Email en blanco
          password: "securepassword",
          name: "New User",
          tipo: "Estudiante",
          phone: "0987654321"
        }
      }
    end

    assert_response :unprocessable_entity  # Verifica que la respuesta sea un 422
  end

  test "should not create user with duplicate email" do
    User.create!(email: "duplicate_user@example.com", password: "password123")
    
    assert_no_difference('User.count') do
      post user_registration_path, params: {
        user: {
          email: "duplicate_user@example.com",  # Email duplicado
          password: "securepassword",
          name: "New User",
          tipo: "Estudiante",
          phone: "0987654321"
        }
      }
    end

    assert_response :unprocessable_entity  # Verifica que la respuesta sea un 422
  end
end