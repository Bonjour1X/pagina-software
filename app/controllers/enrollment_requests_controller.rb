class EnrollmentRequestsController < ApplicationController
  before_action :set_course

  def index
    @enrollment_requests = @course.enrollment_requests.where(status: 'pending')
  end

  def create
    @enrollment_request = current_user.enrollment_requests.new(course: @course)
    if @enrollment_request.save
      redirect_to @course, notice: 'Solicitud de inscripción enviada.'
    else
      redirect_to @course, alert: 'No se pudo enviar la solicitud de inscripción.'
    end
  end

  def approve
    @enrollment_request = @course.enrollment_requests.find(params[:id])
    @enrollment_request.update(status: 'approved')
    redirect_to course_enrollment_requests_path(@course), notice: 'Solicitud aprobada.'
  end

  def reject
    @enrollment_request = @course.enrollment_requests.find(params[:id])
    @enrollment_request.update(status: 'rejected')
    redirect_to course_enrollment_requests_path(@course), notice: 'Solicitud rechazada.'
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end
end