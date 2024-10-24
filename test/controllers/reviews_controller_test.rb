require "test_helper"

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course = courses(:course_one)  
    @review = reviews(:review_one)
  end

  test "should get index" do
    get course_reviews_url(@course)  # Actualiza a course_reviews_url
    assert_response :success
  end

  test "should show review" do
    get course_review_url(@course, @review)  # Actualiza a course_review_url
    assert_response :success
  end

  test "should get new" do
    get new_course_review_url(@course)  # Actualiza a new_course_review_url
    assert_response :success
  end

  test "should get edit" do
    get edit_course_review_url(@course, @review)  # Actualiza a edit_course_review_url
    assert_response :success
  end

  test "should create review" do
    @course = courses(:course_one)  # Cargar el curso desde los fixtures
    @user = users(:user_one)        # Cargar el usuario desde los fixtures

    sign_in @user  # Simular que el usuario ha iniciado sesión (si estás usando Devise o similar)

    assert_difference('Review.count', 1) do
      post course_reviews_path(@course), params: { review: { content: "New review", rating: 4 } }
    end
    assert_redirected_to course_reviews_path(@course)
  end

  test "should update review" do
    patch course_review_url(@course, @review), params: { review: { content: "Updated review content", rating: 4 } }
    assert_response :redirect
  end

  test "should destroy review" do
    delete course_review_url(@course, @review)  # Actualiza a course_review_url
    assert_response :redirect
  end
end
