# Modelo de Classes para crear clases
# app/models/course.rb
class Course < ApplicationRecord
  belongs_to :user
  has_many :evaluations, dependent: :destroy
  has_many :enrollment_requests, dependent: :destroy
end