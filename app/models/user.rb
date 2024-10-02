class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :tipo, presence: true, inclusion: { in: ["Estudiante", "Profesor"], message: "no es válido" }
  validates :name, presence: true
  validates :phone, presence: true
end
