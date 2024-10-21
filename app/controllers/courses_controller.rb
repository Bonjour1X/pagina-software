# app/controllers/courses_controller.rb
class CoursesController < ApplicationController
  before_action :authenticate_user!

  def index
    #@courses = Course.all
    @available_courses = Course.where.not(user: current_user)
    @enrolled_courses = current_user.enrolled_courses
  end

  def show
    @course = Course.find(params[:id])
    @enrollment_request = EnrollmentRequest.find_by(user: current_user, course: @course)
    @students = @course.enrollments.includes(:user) # Obtener estudiantes inscritos
    @evaluations = @course.evaluations.includes(:questions) # Obtener evaluaciones del curso
    #@evaluation = Evaluation.new
    #@enrollment_request = EnrollmentRequest.new
    #@students_with_grades = @course.users.includes(:evaluations)  # Aquí se obtiene la lista de usuarios inscritos
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
    if current_user.tipo == "Profesor"
      @courses = current_user.courses
    else
      @courses = current_user.enrolled_courses
    end
  end

  # Eliminar clases
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    flash[:notice] = "Clase eliminada: #{@course.title}"
    redirect_to courses_path
  end
  
  def available_courses
    @courses = Course.where.not(id: current_user.enrolled_courses.pluck(:id))
                     .where.not(user: current_user)
  end

  # Acción para mostrar las clases dictadas por el profesor
  def taught_classes
    @courses = current_user.courses
  end

  def leave
    @course = Course.find(params[:id])
    enrollment_request = current_user.enrollment_requests.find_by(course: @course)
    if enrollment_request&.destroy
      redirect_to courses_path, notice: 'Has salido de la clase exitosamente.'
    else
      redirect_to @course, alert: 'No se pudo salir de la clase.'
    end
  end

  # Ver mis cursos idea
  def enrolled_courses
    @enrolled_courses = current_user.enrolled_courses
  end
  
  def participants
    @course = Course.find(params[:id])
    @students = @course.enrollments.includes(:user) # Obtener estudiantes inscritos
    @evaluations = @course.evaluations.includes(:questions) # Obtener evaluaciones del curso
  end
  private

  def course_params
    params.require(:course).permit(:title, :description, :scheduled_date, :materials, :modality)
  end
end
