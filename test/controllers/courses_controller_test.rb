require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  def setup
    @user = users(:user_one)
    @course = courses(:course_one)
    sign_in @user
  end
  #OK
  test "should belong to user" do
    course = courses(:course_one)
    assert_equal users(:profesor_one), course.user
  end
  #OK
  test "course should be valid" do
    assert @course.valid?
  end
  #OK
  test "title should be present" do
    @course.title = " "
    assert_not @course.valid?
  end
  #OK
  test "user should be present" do
    @course.user = nil
    assert_not @course.valid?
  end
  
  #ERROR
  #test "should get enrolled courses" do
  #  get enrolled_courses_url
  #  assert_response :success
  #end
  #ERROR
  #test "should get my_courses" do
  #  get my_courses_url
  #   assert_response :success
  #end

  #ERROR
  #test "should get available_courses" do
  #  get available_courses_url
  #  assert_response :success
  #end

  #ERROR
  #test "should get taught_classes" do
  #  get taught_classes_url
  #  assert_response :success
  #end

  #ERROR
  #test "should get student_evaluations for a course" do
  #  get student_evaluations_course_url(@course)
  #  assert_response :success
  #end

  #ERROR
  #test "should get form_documents for a course" do
  #  get form_documents_course_url(@course)
  #  assert_response :success
  #end

  #ERROR
  #test "chat should have an activity" do
  #  chat = chats(:some_chat) # Suponiendo que tienes un fixture para chats
  #  assert chat.activity.present?
  #end

  #No esta implementado, para un futuro muy lejano
  #test "scheduled_date should not be in the past" do
  #  @course.scheduled_date = 1.day.ago
  #  assert_not @course.valid?
  #end
end

