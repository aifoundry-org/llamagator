# frozen_string_literal: true

class Assertion < ApplicationRecord
  belongs_to :user
  belongs_to :model_version, optional: true
  has_many :assertion_results, dependent: :destroy

  enum :assertion_type, { exclude_all: 0, include_all: 1, include_any: 2, model_version: 3 }, scopes: true, default: :exclude_all

  default_scope { order(id: :desc) }

  validates :model_version, presence: true, if: -> { assertion_type == 'model_version' }
end
