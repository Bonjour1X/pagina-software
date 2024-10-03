# Modelo de Classes para crear clases
class Class < ApplicationRecord
  belongs_to :user
  has_many :evaluations
  has_many :enrollment_requests
  validates :title, :scheduled_date, :modality, presence: true
end