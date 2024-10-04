# app/controllers/enrollment_requests_controller.rb
class EnrollmentRequestsController < ApplicationController
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
    @enrollment_request = current_user.enrollment_requests.build(course: @course)
    
    if @enrollment_request.save
      redirect_to @course, notice: 'Solicitud de inscripción enviada.'
    else
      redirect_to @course, alert: 'Error al enviar la solicitud.'
    end
  end

  private

  # Encuentra la solicitud de inscripción por su ID
  def find_enrollment_request
    @enrollment_request = EnrollmentRequest.find(params[:id])
  end
end