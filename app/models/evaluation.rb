# Creacion de evaluacion simple
# app/models/evaluation.rb
class Evaluation < ApplicationRecord
  belongs_to :course
  has_many :questions, dependent: :destroy
  validates :name, :evaluation_method, :start_date, :end_date, presence: true
end