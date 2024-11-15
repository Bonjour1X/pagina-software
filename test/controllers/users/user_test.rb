require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Prueba la validación del campo tipo
  #test "should not save user without tipo" do
  #  user = User.new(name: "Juan", phone: "1234567890", email: "juan@example.com", password: "password")
  #  assert_not user.save, "Saved the user without a tipo"
  #end

  #test "should not save user with invalid tipo" do
  #  user = User.new(name: "Juan", phone: "1234567890", email: "juan@example.com", password: "password", tipo: "Invalid")
  #  assert_not user.save, "Saved the user with an invalid tipo"
  #end

  #test "should save user with valid tipo" do
  #  user = User.new(name: "Juan", phone: "1234567890", email: "juan@example.com", password: "password", tipo: "Estudiante")
  #  assert user.save, "Couldn't save the user with a valid tipo"
  #end

  # Prueba la relación con los cursos
  #test "should have many courses" do
  #  user = users(:one) # Asegúrate de tener fixtures con usuarios en test/fixtures/users.yml
  #  assert_respond_to user, :courses
  #end

  #test "should enroll in approved courses" do
  #  user = users(:one) # Asegúrate de tener usuarios y cursos en los fixtures
  #  course = courses(:approved_course) # Usa un curso aprobado en fixtures
  #  assert_includes user.enrolled_courses, course
  #end

  #test "should not enroll in unapproved courses" do
  #  user = users(:one)
  #  course = courses(:unapproved_course) # Usa un curso no aprobado en fixtures
  #  assert_not_includes user.enrolled_courses, course
  #end

  ## Prueba el método display_title
  #test "should return admin display title" do
  #  user = users(:admin)  # Suponiendo que tengas un fixture con el admin
  #  assert_equal "#{user.name} ★ Administrador Estrella ★", user.display_title
  #end

  #test "should return regular user display title" do
  #  user = users(:one)
  #  assert_equal "Estudiante: #{user.name}", user.display_title
  #end
end
