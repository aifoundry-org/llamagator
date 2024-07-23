# frozen_string_literal: true

class TestResultDecorator < ApplicationDecorator
  delegate_all

  def assertions_state
    return '' unless object.completed?

    return 'passed' if object.assertion_results.all?(&:passed?)

    'failed'
  end
end
