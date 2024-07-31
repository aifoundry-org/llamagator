# frozen_string_literal: true

module Assertions
  class IncludeAll < Base
    def call(result)
      values.all? { |value| result&.include?(value) }
    end
  end
end
