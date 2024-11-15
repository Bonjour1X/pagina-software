# Modelo de Classes para crear clases
# app/models/course.rb
class Course < ApplicationRecord
  scope :public_courses, -> { where(public: true) }
  belongs_to :user
  has_many :evaluations, dependent: :destroy
  has_many :enrollment_requests, dependent: :destroy

  has_many :enrolled_users, through: :enrollment_requests, source: :user 
  has_many_attached :documents
  has_one :chat, dependent: :destroy
  
  has_many :reviews, dependent: :destroy

  has_many :users, through: :enrollment_requests
  validates :title, :scheduled_date, :modality, presence: true

  after_create :crear_chat

  has_many :deseados, dependent: :destroy
  has_many :usuarios_deseadores, through: :deseados, source: :user

  def crear_chat
    Chat.create(course: self)
  end

end