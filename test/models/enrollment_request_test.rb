require 'test_helper'

class EnrollmentRequestTest < ActiveSupport::TestCase
  def setup
    @user = users(:user_one)  # Asegúrate de tener un usuario en tus fixtures
    @course = courses(:course_one)  # Asegúrate de tener un curso en tus fixtures
    @enrollment_request = EnrollmentRequest.new(
      user: @user,
      course: @course,
      status: "pending"  # Valor por defecto
    )
  end

  # Validaciones
  test "should be valid" do
    assert @enrollment_request.valid?, @enrollment_request.errors.full_messages.to_sentence
  end

  test "user should be present" do
    @enrollment_request.user = nil
    assert_not @enrollment_request.valid?
  end

  test "course should be present" do
    @enrollment_request.course = nil
    assert_not @enrollment_request.valid?
  end

  test "status should be valid" do
    @enrollment_request.status = "invalid_status"
    assert_not @enrollment_request.valid?
  end

  # Métodos
  test "approved? should return true for approved status" do
    @enrollment_request.status = "approved"
    assert @enrollment_request.approved?
  end

  test "approved? should return false for pending status" do
    @enrollment_request.status = "pending"
    assert_not @enrollment_request.approved?
  end

  test "pending? should return true for pending status" do
    @enrollment_request.status = "pending"
    assert @enrollment_request.pending?
  end

  test "pending? should return false for approved status" do
    @enrollment_request.status = "approved"
    assert_not @enrollment_request.pending?
  end

  test "rejected? should return true for rejected status" do
    @enrollment_request.status = "rejected"
    assert @enrollment_request.rejected?
  end

  test "rejected? should return false for approved status" do
    @enrollment_request.status = "approved"
    assert_not @enrollment_request.rejected?
  end
end