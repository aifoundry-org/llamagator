# frozen_string_literal: true

module Assertions
  class Base
    attr_reader :values

    def initialize(values)
      @values = values
    end
  end
end
