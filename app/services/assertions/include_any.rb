# frozen_string_literal: true

module Assertions
  class IncludeAny < Base
    def call(result)
      values.any? { |value| result&.include?(value) }
    end
  end
end
