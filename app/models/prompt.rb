class Prompt < ApplicationRecord
  belongs_to :user
  has_many :test_results, dependent: :destroy
end
