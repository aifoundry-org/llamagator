# frozen_string_literal: true

module Assertions
  class ExcludeAll < Base
    private

    def validate?(result)
      values.all? { |value| result&.exclude?(value) }
    end
  end
end
