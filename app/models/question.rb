# app/models/question.rb
class Question < ApplicationRecord
  belongs_to :evaluation
  has_many :student_responses, dependent: :destroy
  validates :content, presence: true
  validates :question_type, presence: true
end