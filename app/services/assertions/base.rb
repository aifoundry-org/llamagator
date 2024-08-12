# frozen_string_literal: true

module Assertions
  class Base
    attr_reader :value, :model_version

    def initialize(value, model_version)
      @value = value
      @model_version = model_version
    end

    def call(result)
      state = validate?(result) ? 'passed' : 'failed'

      [state, nil]
    end

    private

    def values
      @values ||= value.to_s.split("\n")
    end
  end
end
