# app/controllers/enrollment_requests_controller.rb
class EnrollmentRequestsController < ApplicationController
  def create
    @course = Course.find(params[:course_id])
    @enrollment_request = current_user.enrollment_requests.build(course: @course)
    if @enrollment_request.save
      redirect_to @course, notice: 'Solicitud de inscripción enviada.'
    else
      redirect_to @course, alert: 'Error al enviar la solicitud.'
    end
  end
end