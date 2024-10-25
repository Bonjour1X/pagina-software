class Chat < ApplicationRecord
  belongs_to :course
  validates :course, presence: true
  has_many :messages, dependent: :destroy
end
