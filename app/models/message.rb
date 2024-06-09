class Message < ApplicationRecord
  belongs_to :chat

  validates :body, presence: true
  validates :from, presence: true
end
