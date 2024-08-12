# frozen_string_literal: true

module Assertions
  class IncludeAny < Base
    private

    def validate?(result)
      values.any? { |value| result&.include?(value) }
    end
  end
end
