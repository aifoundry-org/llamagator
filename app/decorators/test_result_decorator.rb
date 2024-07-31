# frozen_string_literal: true

class TestResultDecorator < ApplicationDecorator
  delegate_all

  def assertions_state
    return '' unless object.completed?

    return 'passed' if object.assertion_results.all?(&:passed?)

    'failed'
  end

  def content
    return '' if object.pending?

    return JSON.parse(object.result).dig('error', 'message') if object.failed?

    return JSON.parse(object.result).dig('choices', 0, 'message', 'content') if object.model_version.executor_type == 'openai'

    return JSON.parse(object.result)[0]['response'] if object.model_version.executor_type == 'ollama'

    JSON.parse(object.result)['content']
  rescue StandardError
    ''
  end
end
