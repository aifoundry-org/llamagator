# frozen_string_literal: true

module Assertions
  class ExcludeAny < Base
    def call(result)
      values.any? { |value| result&.exclude?(value) }
    end
  end
end
