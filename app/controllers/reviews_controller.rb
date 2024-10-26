# app/controllers/reviews_controller.rb
class ReviewsController < ApplicationController
  before_action :set_course
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :verify_enrollment, only: [:new, :create] 

  def index
    @reviews = @course.reviews.order(created_at: :desc)
  end

  def show
    @review = Review.find_by!(course_id: params[:course_id], id: params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to course_path(@course), alert: 'Reseña no encontrada'
  end

  def new
    @review = @course.reviews.build
  end

  def create
    @review = @course.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to course_reviews_path(@course), notice: 'Reseña creada exitosamente'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to course_reviews_path(@course), notice: 'Reseña actualizada'
    else
      render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to course_reviews_path(@course), notice: 'Reseña eliminada'
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_review
    @review = @course.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def verify_enrollment
    enrollment_request = @course.enrollment_requests.find_by(user: current_user)
    
    unless enrollment_request&.status == "approved"  # Verificación específica de estado aprobado
      redirect_to course_path(@course), 
                  alert: 'Solo los estudiantes con inscripción aprobada pueden escribir reseñas.'
    end
  end
end