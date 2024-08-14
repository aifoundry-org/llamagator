# frozen_string_literal: true

class Model < ApplicationRecord
  encrypts :api_key

  belongs_to :user
  has_many :model_versions, dependent: :destroy
  accepts_nested_attributes_for :model_versions, allow_destroy: true, reject_if: :all_blank

  enum :executor_type, { llama: 0, openai: 1, ollama: 2 }, scopes: false, default: :llama

  default_scope { order(id: :desc) }
end
