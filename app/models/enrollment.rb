# app/models/enrollment
class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course
end

#class Evaluation < ApplicationRecord
  #has_many :scores # Asegúrate de tener un modelo Score que almacene las calificaciones
#end

#class Score < ApplicationRecord
  #belongs_to :user
  #belongs_to :evaluation
#end