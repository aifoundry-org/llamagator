# frozen_string_literal: true

class Model < ApplicationRecord
  encrypts :api_key

  belongs_to :user
  has_many :model_versions, dependent: :destroy

  enum :executor_type, %i[base openai], scopes: false, default: :base
end
