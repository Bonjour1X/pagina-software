# app/controllers/enrollment_requests_controller.rb
class EnrollmentRequestsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @class = Class.find(params[:class_id])
      @enrollment_request = current_user.enrollment_requests.build(class: @class)
      if @enrollment_request.save
        redirect_to @class, notice: 'Solicitud de inscripción enviada.'
      else
        redirect_to @class, alert: 'Error al enviar la solicitud.'
      end
    end
  end