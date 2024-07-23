# frozen_string_literal: true

module TestResultsHelper
  def assertions_state(test_result)
    return '' if test_result.pending?

    return 'passed' if test_result.assertion_results.all?(&:passed?)

    'failed'
  end

  def define_assertions_state_class(state)
    case state
    when 'failed'
      'text-red-700 bg-red-100 dark:bg-red-800 dark:text-red-600'
    when 'passed'
      'text-green-700 bg-green-100 dark:bg-green-700 dark:text-green-100'
    end
  end
end
