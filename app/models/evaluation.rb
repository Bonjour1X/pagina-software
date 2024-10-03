# Creacion de evaluacion simple
class Evaluation < ApplicationRecord
  belongs_to :course
  validates :name, :questions, presence: true
  validates :solution, presence: true, unless: -> { evaluation_method == 'Multiple Choice' }
end