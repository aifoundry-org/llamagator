# frozen_string_literal: true

class ModelExecutor
  attr_reader :executor

  def initialize(model_version)
    @executor = executor_by_type(model_version.executor_type).new(model_version)
  end

  def call(prompt)
    executor.call(prompt)
  end

  private

  def executor_by_type(type)
    return Executors::Openai if type == 'openai'

    Executors::Base
  end
end
