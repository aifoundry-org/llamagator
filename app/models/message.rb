class Message < ApplicationRecord
  validates :body, presence: true
  validates :from, presence: true
end
