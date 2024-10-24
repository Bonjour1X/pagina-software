require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  def setup
    @course = courses(:course_one) # Cargar el fixture específico
  end

  test "should belong to user" do
    course = courses(:course_one)
    assert_equal users(:profesor_one), course.user
  end

  test "course should be valid" do
    assert @course.valid?
  end

  test "title should be present" do
    @course.title = " "
    assert_not @course.valid?
  end

  test "user should be present" do
    @course.user = nil
    assert_not @course.valid?
  end
  
  #No esta implementado
  #test "scheduled_date should not be in the past" do
  #  @course.scheduled_date = 1.day.ago
  #  assert_not @course.valid?
  #end
end
