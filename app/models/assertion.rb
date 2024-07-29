# frozen_string_literal: true

class Assertion < ApplicationRecord
  belongs_to :user
  belongs_to :model_version, optional: true

  enum :assertion_type, %i[exclude include model_version], scopes: true, default: :exclude

  default_scope { order(id: :desc) }

  validates :model_version, presence: true, if: -> { assertion_type == 'model_version' }
end
