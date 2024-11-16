require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  # Prueba: es válido con atributos válidos
  test 'valid review' do
    user = users(:user_one) # Usa fixtures
    course = courses(:course_one)
    review = Review.new(content: 'Great course!', rating: 5, user: user, course: course)

    assert review.valid?
  end

  # Prueba: no es válido sin contenido
  test 'invalid without content' do
    review = Review.new(content: nil, rating: 3)

    assert_not review.valid?
    assert_includes review.errors[:content], "can't be blank"
  end

  # Prueba: no es válido sin una calificación (rating)
  test 'invalid without rating' do
    review = Review.new(content: 'Great course!', rating: nil)

    assert_not review.valid?
    assert_includes review.errors[:rating], "can't be blank"
  end

  # Prueba: la calificación debe ser un número entero
  test 'invalid if rating is not an integer' do
    review = Review.new(content: 'Great course!', rating: 4.5)

    assert_not review.valid?
    assert_includes review.errors[:rating], 'must be an integer'
  end

  # Prueba: la calificación no puede ser menor que 1
  test 'invalid if rating is less than 1' do
    review = Review.new(content: 'Great course!', rating: 0)

    assert_not review.valid?
    assert_includes review.errors[:rating], 'must be greater than or equal to 1'
  end

  # Prueba: la calificación no puede ser mayor que 5
  test 'invalid if rating is greater than 5' do
    review = Review.new(content: 'Great course!', rating: 6)

    assert_not review.valid?
    assert_includes review.errors[:rating], 'must be less than or equal to 5'
  end

  # Prueba: relaciones con usuario y curso
  test 'belongs to user and course' do
    user = users(:one)
    course = courses(:one)
    review = Review.new(content: 'Great course!', rating: 4, user: user, course: course)

    assert_equal user, review.user
    assert_equal course, review.course
  end
end
