# app/controllers/courses_controller.rb
class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    @evaluation = Evaluation.new
    @enrollment_request = EnrollmentRequest.new
  end

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.build(course_params)
    if @course.save
      redirect_to @course, notice: 'Clase creada exitosamente.'
    else
      render :new
    end
  end

  def my_courses
    @courses = current_user.courses
  end

  # Eliminar clases
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to courses_path, notice: 'Clase eliminada exitosamente.'
  end
  
  def available_courses
    @courses = Course.where.not(user: current_user)
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :scheduled_date, :materials, :modality)
  end
end
