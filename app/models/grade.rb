# app/models/grade.rb
class Grade < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :evaluation
  
  validates :score, 
            presence: true, 
            numericality: { greater_than_or_equal_to: 1.0, less_than_or_equal_to: 7.0 }
end