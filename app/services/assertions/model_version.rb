# frozen_string_literal: true

module Assertions
  class ModelVersion < Base
    def call(result)
      result = ModelExecutor.new(model_version).call([value, result].join(' '))

      return ['failed', nil] if result[:status] == :failed

      content = JSON.parse(result[:result]).dig(*model_version.content_path)

      state = ActiveModel::Type::Boolean.new.cast(content) ? 'passed' : 'failed'

      [state, result[:result]]
    rescue StandardError
      ['failed', nil]
    end
  end
end
