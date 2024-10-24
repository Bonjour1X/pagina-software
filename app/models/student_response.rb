# app/models/student_response.rb
class StudentResponse < ApplicationRecord
  belongs_to :user
  belongs_to :question
  
  validates :content, presence: true
  validates :user_id, uniqueness: { scope: :question_id }
end