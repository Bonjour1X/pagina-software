# app/models/user.rb
class User < ApplicationRecord
  #validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  #validates :encrypted_password, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :tipo, presence: true, inclusion: { in: ["Estudiante", "Profesor"], message: "no es válido" }
  validates :name, presence: true
  validates :phone, presence: true
  
  def admin?
    email == 'admin@admin.com'  # email del admin
  end

  def display_title
    if admin?
      "#{name} ★ Administrador Estrella ★"
    else
      "#{tipo}: #{name}"  # Mostrará "Profesor: Antonio" o "Estudiante: Juan"
    end
  end

  # Se encarga del historial de evaluaciones
  has_many :student_responses, dependent: :destroy
  # Para la reseña
  has_many :reviews, dependent: :destroy
  # Habilita la cantidad de clases
  has_many :courses, dependent: :destroy #, dependent: :destroy
  has_many :enrollment_requests
  has_many :enrolled_courses, -> { where(enrollment_requests: { status: 'approved' }) }, 
           through: :enrollment_requests, 
           source: :course
  has_many :messages, dependent: :destroy

  has_many :deseados, dependent: :destroy
  has_many :clases_deseadas, through: :deseados, source: :course

  has_one_attached :imagen
end
