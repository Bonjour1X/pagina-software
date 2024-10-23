# app/models/course.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :tipo, presence: true, inclusion: { in: ["Estudiante", "Profesor"], message: "no es válido" }
  validates :name, presence: true
  validates :phone, presence: true

  # Se encarga del historial de evaluaciones
  has_many :student_responses, dependent: :destroy
  # Para la reseña
  has_many :reviews, dependent: :destroy
  # Habilita la cantidad de clases
  has_many :courses #cambio de classes -> courses
  has_many :enrollment_requests
  has_many :enrolled_courses, -> { where(enrollment_requests: { status: 'approved' }) }, 
           through: :enrollment_requests, 
           source: :course
           

end
