# frozen_string_literal: true

class Assertion < ApplicationRecord
  belongs_to :user

  enum :assertion_type, { exclude_all: 0, include_all: 1, include_any: 2 }, scopes: true, default: :exclude_all

  default_scope { order(id: :desc) }
end
