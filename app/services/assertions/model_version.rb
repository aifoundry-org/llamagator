# frozen_string_literal: true

module Assertions
  class ModelVersion < Base
    def call(result)
      result = ModelExecutor.new(model_version).call([values, result].flatten.join(' '))

      return false if result[:status] == :failed

      return ActiveModel::Type::Boolean.new.cast(JSON.parse(result[:result]).dig('choices', 0, 'message', 'content')) if model_version.executor_type == 'openai'

      ActiveModel::Type::Boolean.new.cast(JSON.parse(result[:result])['content'])
    rescue StandardError
      false
    end
  end
end
