# frozen_string_literal: true

module Assertions
  class Base
    attr_reader :values, :model_version

    def initialize(values, assertion)
      @values = values
      @model_version = assertion
    end
  end
end
