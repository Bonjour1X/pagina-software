# Modelos de Evaluacion
class Evaluation < ApplicationRecord
    belongs_to :class
    validates :name, :questions, :evaluation_method, presence: true
end