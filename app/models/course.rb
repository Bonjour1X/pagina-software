# Modelo de Classes para crear clases
# app/models/course.rb
class Course < ApplicationRecord
  scope :public_courses, -> { where(public: true) }
  belongs_to :user
  has_many :evaluations, dependent: :destroy
  has_many :enrollment_requests, dependent: :destroy
  #ojo
  has_many :enrollments, dependent: :destroy # Agregado para permitir acceder a inscripciones

  # Cambié esta línea para relacionar directamente con los enrollments
  has_many :enrolled_users, through: :enrollments, source: :user 
  has_many_attached :documents
  has_one :chat, dependent: :destroy
  
  #has_many :enrollments # Agregado
  has_many :enrolled_users, through: :enrollment_requests, source: :user
  # Para reviews
  has_many :reviews, dependent: :destroy
  #has_many :users, through: :enrollments # Agregado
  validates :title, :scheduled_date, :modality, presence: true

  after_create :crear_chat

  def crear_chat
    Chat.create(course: self)
  end

end