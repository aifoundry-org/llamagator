# frozen_string_literal: true

class ModelExecutor
  attr_reader :executor

  def initialize(model_version)
    @executor = Executors.const_get(model_version.executor_type.camelize).new(model_version)
  end

  def call(prompt)
    executor.call(prompt)
  end
end
