# frozen_string_literal: true

module Assertions
  class ModelVersion < Base
    TRUE_VALUES = %w[1 t true on].to_set.freeze

    def call(result)
      result = ModelExecutor.new(model_version).call([value, result].join(' '))

      return ['failed', nil] if result[:status] == :failed

      content = JSON.parse(result[:result]).dig(*model_version.content_path)

      state = TRUE_VALUES.include?(content.to_s.downcase) ? 'passed' : 'failed'

      [state, result[:result]]
    rescue StandardError
      ['failed', nil]
    end
  end
end
