# app/controllers/enrollment_requests_controller.rb
class EnrollmentRequestsController < ApplicationController
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
    @course = Course.find(params[:course_id])
    @enrollment_request = current_user.enrollment_requests.new(course: @course)
    if @enrollment_request.save
      flash[:notice] = "Solicitud de inscripción enviada para #{@course.title}"
    else
      flash[:alert] = "No se pudo enviar la solicitud"
    end
    redirect_to @course
  end

  def approve
    @enrollment_request = EnrollmentRequest.find(params[:id])
    @enrollment_request.update(status: 'approved')
    redirect_to course_enrollment_requests_path(@enrollment_request.course), notice: 'Solicitud aprobada'
  end

  def reject
    @enrollment_request = EnrollmentRequest.find(params[:id])
    @enrollment_request.update(status: 'rejected')
    redirect_to course_enrollment_requests_path(@enrollment_request.course), notice: 'Solicitud rechazada'
  end

  private

  # Encuentra la solicitud de inscripción por su ID
  def find_enrollment_request
    @enrollment_request = EnrollmentRequest.find(params[:id])
  end
end