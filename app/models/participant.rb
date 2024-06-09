class Participant < ApplicationRecord
  validates :name, presence: true
end
