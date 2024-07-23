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

    JSON.parse(object.result)['content'] if object.completed?
  rescue StandardError
    ''
  end
end
