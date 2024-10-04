# app/controllers/enrollment_requests_controller.rb
class EnrollmentRequestsController < ApplicationController
  def index
    @course = Course.find(params[:course_id])
    @enrollment_requests = @course.enrollment_requests.where(status: 'pending')
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
end