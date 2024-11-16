# test/models/user_test.rb
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      email: "unique_test@example.com",
      password: "password123",
      tipo: "Estudiante",
      name: "Juan",
      phone: "1234567890"
    )
  end

  # Validaciones
  test "should be valid" do
    assert @user.valid?,  @user.errors.full_messages.to_sentence
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "tipo should be present" do
    @user.tipo = " "
    assert_not @user.valid?
  end

  test "tipo should be valid" do
    @user.tipo = "InvalidType"
    assert_not @user.valid?
  end

  test "name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "phone should be present" do
    @user.phone = " "
    assert_not @user.valid?
  end

  # Métodos
  test "admin? should return true for admin email" do
    @user.email = "admin@admin.com"
    assert @user.admin?
  end

  test "admin? should return false for non-admin email" do
    @user.email = "test@example.com"
    assert_not @user.admin?
  end

  test "display_title should return admin title for admin" do
    @user.email = "admin@admin.com"
    assert_equal "Juan ★ Administrador Estrella ★", @user.display_title
  end

  test "display_title should return regular title for student" do
    @user.tipo = "Estudiante"
    assert_equal "Estudiante: Juan", @user.display_title
  end
  
  test "display_title should return regular title for professor" do
    @user.tipo = "Profesor"
    assert_equal "Profesor: Juan", @user.display_title
  end
end