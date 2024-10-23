# app/models/option.rb
class Option < ApplicationRecord
  belongs_to :question
  validates :content, presence: true
end