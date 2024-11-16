require "test_helper"

class DeseadoTest < ActiveSupport::TestCase
  test "should belong to a user and a course" do
    deseado = deseados(:one) # Usa el fixture 'one'
    assert_equal users(:user_one), deseado.user
    assert_equal courses(:course_one), deseado.course
  end

  test "should not save without user or course" do
    deseado = Deseado.new
    assert_not deseado.save, "Saved the deseado without a user and course"
  end
end
