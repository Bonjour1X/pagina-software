# app/controllers/enrollment_requests_controller.rb
class EnrollmentRequestsController < ApplicationController

  before_action :set_course


  def index
    @course = Course.find(params[:course_id])
    @enrollment_requests = @course.enrollment_requests.where(status: 'pending')
  end
  before_action :find_enrollment_request, only: [:accept, :reject]

  # Acción para que el profesor acepte la solicitud
  def accept
    @course = @enrollment_request.course
    if @course.users.include?(@enrollment_request.user)
      redirect_to @course, alert: 'El usuario ya está inscrito en el curso.'
    else
      @course.users << @enrollment_request.user
      @enrollment_request.destroy # La solicitud ya no es necesaria
      redirect_to @course, notice: 'Solicitud aceptada y usuario inscrito en el curso.'
      # Aquí podrías agregar el envío de una notificación al usuario
    end
  end

  # Acción para que el profesor rechace la solicitud
  def reject
    @enrollment_request.destroy
    redirect_to @enrollment_request.course, notice: 'Solicitud rechazada.'
    # Aquí podrías agregar el envío de una notificación al usuario
  end

  def create
    # Eliminar cualquier solicitud existente para este curso y usuario
    existing_request = @course.enrollment_requests.find_by(user: current_user)
    existing_request.destroy if existing_request

    # Crear una nueva solicitud
    @enrollment_request = @course.enrollment_requests.new(user: current_user, status: 'pending')
    
    if @enrollment_request.save
      redirect_to @course, notice: 'Solicitud de inscripción enviada.'
    else
      redirect_to @course, alert: 'No se pudo enviar la solicitud de inscripción.'
    end
  end

  def approve
    @enrollment_request = EnrollmentRequest.find(params[:id])
    @enrollment_request.update(status: 'approved')
    redirect_to course_enrollment_requests_path(@enrollment_request.course), notice: 'Solicitud aprobada'
  end

  # Encuentra la solicitud de inscripción por su ID
  def find_enrollment_request
    @enrollment_request = EnrollmentRequest.find(params[:id])
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

end