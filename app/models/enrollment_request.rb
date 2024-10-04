# Modelo de Enviar solicitud
# app/models/enrollment_request.rb
class EnrollmentRequest < ApplicationRecord
    belongs_to :user
    belongs_to :course
end