# app/models/question.rb
class Question < ApplicationRecord
  belongs_to :evaluation
  validates :content, presence: true
  validates :question_type, presence: true
end