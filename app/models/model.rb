class Model < ApplicationRecord
  belongs_to :user
  has_many :model_versions, dependent: :destroy
end
