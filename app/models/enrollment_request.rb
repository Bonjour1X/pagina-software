# Modelo de Enviar solicitud
# app/models/enrollment_request.rb
class EnrollmentRequest < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :status, presence: true, inclusion: { in: %w[approved pending rejected], message: "no es válido" }
  # Añade estos métodos
  def approved?
    status == 'approved'
  end

  def pending?
    status == 'pending'
  end

  def rejected?
    status == 'rejected'
  end
end