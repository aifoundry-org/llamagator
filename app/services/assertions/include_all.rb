# frozen_string_literal: true

module Assertions
  class IncludeAll < Base
    private

    def validate?(result)
      values.all? { |value| result&.include?(value) }
    end
  end
end
