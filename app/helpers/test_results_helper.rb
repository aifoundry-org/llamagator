# frozen_string_literal: true

module TestResultsHelper
  def define_assertions_state_class(state)
    case state
    when 'failed'
      'text-red-700 bg-red-100 dark:bg-red-800 dark:text-red-600'
    when 'passed'
      'text-green-700 bg-green-100 dark:bg-green-700 dark:text-green-100'
    end
  end
end
