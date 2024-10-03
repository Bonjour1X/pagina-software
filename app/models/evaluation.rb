# Creacion de evaluacion simple
class Evaluation < ApplicationRecord
  belongs_to :course
  validates :name, :questions, :solution, presence: true
end