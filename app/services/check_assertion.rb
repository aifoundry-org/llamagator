# frozen_string_literal: true

class CheckAssertion
  attr_reader :assertion

  def initialize(assertion)
    @assertion = assertion
  end

  def call(result)
    return 'passed' if check_assertion(result)

    'failed'
  end

  private

  def check_assertion(result)
    return execute_model_version_assertion(result) if assertion.model_version?

    assertion&.value&.split('\n')&.all? { |value| assertion.include? ? result&.include?(value) : result&.exclude?(value) }
  end

  def execute_model_version_assertion(result)
    model_version = assertion.model_version

    result = ModelExecutor.new(model_version).call([assertion.value, result].join(' '))

    return false if result[:status] == :failed

    return ActiveModel::Type::Boolean.new.cast(JSON.parse(result[:result]).dig('choices', 0, 'message', 'content')) if model_version.executor_type == 'openai'

    ActiveModel::Type::Boolean.new.cast(JSON.parse(result[:result])['content'])
  rescue StandardError
    false
  end
end
