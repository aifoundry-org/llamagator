# frozen_string_literal: true

module Assertions
  class Base
    attr_reader :value, :model_version

    def initialize(value, model_version)
      @value = value
      @model_version = model_version
    end

    private

    def values
      @values ||= value.to_s.split("\n")
    end
  end
end
