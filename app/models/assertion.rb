# frozen_string_literal: true

class Assertion < ApplicationRecord
  belongs_to :user

  enum :assertion_type, %i[exclude include], scopes: true, default: :exclude

  default_scope { order(id: :desc) }
end
