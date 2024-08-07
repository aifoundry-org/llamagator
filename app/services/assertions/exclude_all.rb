# frozen_string_literal: true

module Assertions
  class ExcludeAll < Base
    def call(result)
      values.all? { |value| result&.exclude?(value) }
    end
  end
end
