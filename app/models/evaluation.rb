# Creacion de evaluacion simple
# app/models/evaluation.rb
# app/models/evaluation.rb
class Evaluation < ApplicationRecord
  belongs_to :course
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true

  validates :name, :evaluation_method, :start_date, :end_date, :instructions, presence: true
end