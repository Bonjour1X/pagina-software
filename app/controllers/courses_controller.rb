# app/controllers/courses_controller.rb
class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
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
  # app/controllers/courses_controller.rb
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    flash[:notice] = "Clase eliminada: #{@course.title}"
    redirect_to courses_path
  end
  
  def available_courses
    @courses = Course.where.not(user: current_user)
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :scheduled_date, :materials, :modality)
  end
end
