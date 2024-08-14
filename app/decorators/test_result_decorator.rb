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

    return json_result.dig('error', 'message') if object.failed?

    json_result.dig(*object.model_version.content_path)
  rescue StandardError
    ''
  end

  private

  def json_result
    @json_result ||= JSON.parse(object.result)
  end
end
