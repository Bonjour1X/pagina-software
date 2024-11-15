class Message < ApplicationRecord
  scope :public_messages, -> { where(public: true) }
  belongs_to :chat
  belongs_to :user
end
