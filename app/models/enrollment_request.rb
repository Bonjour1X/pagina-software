# Modelo de Enviar solicitud
class EnrollmentRequest < ApplicationRecord
    belongs_to :user
    belongs_to :course
end