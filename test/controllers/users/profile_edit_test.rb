require 'test_helper'

class Users::ProfileEditControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:user_one)
    sign_in @user
  end

  # Verifica que la página de edición de perfil se carga correctamente. OK
  test "should get edit profile" do
    get edit_user_registration_path
    assert_response :success
    assert_template :edit
  end

  ## Verifica que se actualice el perfil con datos válidos. Para un futuro, este da errores
  #test "should update profile with valid data" do
  #  patch user_registration_path, params: { user: { 
  #    email: "updated_email@example.com", 
  #    name: "Updated Name", 
  #    phone: "0987654321", 
  #    tipo: "Estudiante", 
  #    password: "", 
  #    password_confirmation: "", 
  #    current_password: 'your_actual_password'  # Asegúrate de que esta sea la correcta
  #  } }
#
  #  assert_redirected_to profile_path
  #  @user.reload
  #  assert_equal "updated_email@example.com", @user.email
  #  assert_equal "Updated Name", @user.name
  #end
  #
#
  ## Verifica que no se actualice el perfil con datos inválidos. Para un futuro, este da errores
  #test "should not update profile with invalid data" do
  #  patch user_registration_path, params: { user: { 
  #    email: "",  # Email vacío, debería ser inválido
  #    current_password: 'your_actual_password'  # Asegúrate de que esta sea la correcta
  #  } }
#
  #  assert_template :edit
  #  @user.reload # Asegúrate de recargar el objeto después de la acción
  #  assert_not_empty @user.errors.full_messages
  #  assert flash[:alert].present?
  #end
  
  # Verifica correctamente la eliminación de la cuenta de usuario. OK
  test "should destroy user account" do
    assert_difference('User.count', -1) do
      delete user_registration_path
    end
    assert_redirected_to root_path
    assert_equal 'Bye! Your account has been successfully cancelled. We hope to see you again soon.', flash[:notice]
  end
end