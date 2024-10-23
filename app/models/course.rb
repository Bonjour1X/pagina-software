# Modelo de Classes para crear clases
# app/models/course.rb
class Course < ApplicationRecord
  belongs_to :user
  has_many :evaluations, dependent: :destroy
  has_many :enrollment_requests, dependent: :destroy
  
  #has_many :enrollments # Agregado
  has_many :enrolled_users, through: :enrollment_requests, source: :user
  # Para reviews
  has_many :reviews, dependent: :destroy
  #has_many :users, through: :enrollments # Agregado
  validates :title, :scheduled_date, :modality, presence: true
  
end