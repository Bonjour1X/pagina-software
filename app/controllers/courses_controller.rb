# app/controllers/courses_controller.rb
class CoursesController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @courses = Course.all
    @available_courses = Course.where.not(user: current_user)
    @enrolled_courses = current_user.enrolled_courses
  end

  def show
    @course = Course.find(params[:id])
    @enrollment_request = EnrollmentRequest.find_by(user: current_user, course: @course)
    #@students = @course.enrollments.includes(:user) # Obtener estudiantes inscritos
    #@evaluations = @course.evaluations.includes(:questions) # Obtener evaluaciones del curso
    #@evaluation = Evaluation.new
    #@enrollment_request = EnrollmentRequest.new
    #@students_with_grades = @course.users.includes(:evaluations)  # Aquí se obtiene la lista de usuarios inscritos
    
    # Agregamos esto para obtener los alumnos inscritos y sus evaluaciones
    if current_user.tipo == "Profesor" && current_user == @course.user
      @enrolled_students = @course.enrolled_users.includes(:enrollment_requests)
      @student_evaluations = {}
      @enrolled_students.each do |student|
        @student_evaluations[student.id] = @course.evaluations.map do |evaluation|
          {
            evaluation: evaluation,
            status: evaluation_status(student, evaluation)
          }
        end
      end
    end
  end

  def visitantes
    if params[:id].present?
      @course = Course.find(params[:id])

    else
      redirect_to courses_path, alert: 'Curso no encontrado'
    end
  
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
      @enrolled_courses = current_user.enrolled_courses  # Agregar esto para cursos donde está inscrito
    else
      @courses = current_user.enrolled_courses
    end
  end

  # Eliminar clases
  #def destroy
  #  @course = Course.find(params[:id])
  #  @course.destroy
  #  flash[:notice] = "Clase eliminada: #{@course.title}"
  #  redirect_to courses_path
  #end

  def destroy
    @course = Course.find(params[:id])
    if current_user.admin? || current_user == @course.user
      if @course.destroy
        redirect_to courses_path, notice: "Curso eliminado correctamente"
      else
        redirect_to courses_path, alert: "No se pudo eliminar el curso"
      end
    else
      redirect_to courses_path, alert: "No tienes permiso para esta acción"
    end
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

  #SUBIDA DE ARCHIVOS
  def form_documents
    @course = Course.find(params[:id]) 
  end

  def form_subir_documents
    @course = Course.find(params[:id]) 
  end

  def upload_documents
    @course = Course.find(params[:id])
    Rails.logger.info "CLOUDINARY_CLOUD_NAME: #{ENV['CLOUDINARY_CLOUD_NAME']}"
    Rails.logger.info "CLOUDINARY_API_KEY: #{ENV['CLOUDINARY_API_KEY']}"
    Rails.logger.info "CLOUDINARY_API_SECRET: #{ENV['CLOUDINARY_API_SECRET']}" 
    if @course.update(course_params)
      redirect_to course_path(@course)
    else
      render :upload_documents
    end
  end

  def subir_documents
    @course = Course.find(params[:id])
    params[:course][:documents].each do |document|
      @course.documents.attach(document)
    Rails.logger.info "CLOUDINARY_CLOUD_NAME: #{ENV['CLOUDINARY_CLOUD_NAME']}"
    Rails.logger.info "CLOUDINARY_API_KEY: #{ENV['CLOUDINARY_API_KEY']}"
    Rails.logger.info "CLOUDINARY_API_SECRET: #{ENV['CLOUDINARY_API_SECRET']}"
      
    end
    redirect_to course_path(@course)
  end

  def eliminar_documents
    @course = Course.find(params[:id])
    Cloudinary.config do |config|
      config.cloud_name = ENV['CLOUDINARY_CLOUD_NAME']
      config.api_key = ENV['CLOUDINARY_API_KEY']
      config.api_secret = ENV['CLOUDINARY_API_SECRET']
    end
    @document = @course.documents.find_by(blob_id: params[:blob_id])
    @document.purge
    redirect_to course_path(@course)
  end


  def student_evaluations
    @course = Course.find(params[:id])
    @enrolled_students = @course.enrolled_users.includes(:enrollment_requests)
    @student_evaluations = {}
    
    @enrolled_students.each do |student|
      @student_evaluations[student.id] = @course.evaluations.map do |evaluation|
        {
          evaluation: evaluation,
          status: evaluation_status(student, evaluation),
          score: calculate_score(student, evaluation)
        }
      end
    end
  end
  
  def participants
    @course = Course.find(params[:id])
    # Cambiar a enrollment_requests aprobados
    @students = @course.enrollment_requests.approved.includes(:user)
    @evaluations = @course.evaluations.includes(:questions)
  end
  
  private

  def evaluation_status(_student, evaluation)
    if Time.current < evaluation.start_date
      'Pendiente'
    elsif Time.current > evaluation.end_date
      'Finalizada'
    else
      'En curso'
    end
  end

  def calculate_score(student, evaluation)
    # Aquí implementaremos la lógica de calificación
    total_questions = evaluation.questions.count
    correct_answers = evaluation.questions.count { |question| correct_answer?(student, q) }
    
    return 0 if total_questions == 0
    (correct_answers.to_f / total_questions * 7).round(1)
  end
  
  def correct_answer?(_student, _question)
    # Implementar lógica según tipo de pregunta
    # Por ahora retornamos nil hasta implementar respuestas
    nil
  end

  def course_params
    params.require(:course).permit(:title, :description, :scheduled_date, :materials, :modality, documents: [])
  end

  # Método para verificar la membresía y redirigir si no cumple los requisitos
  def check_membership
    unless user_signed_in?
      redirect_to visitantes_path, alert: "Por favor, inicia sesión o regístrate para ver más detalles del curso."
      return
    end

    # Suponiendo que `@course` es el curso actual cargado
    @course = Course.find(params[:id])

    unless current_user == @course.user || @course.enrollment_requests.find_by(user: current_user)&.approved?
      redirect_to visitantes_path, alert: "Acceso restringido solo para miembros."
    end
end
end
