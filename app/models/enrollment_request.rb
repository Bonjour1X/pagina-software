# Modelo de Enviar solicitud
class EnrollmentRequest < ApplicationRecord
    belongs_to :user
    belongs_to :class
    validates :status, inclusion: { in: %w[pending accepted rejected] }
end