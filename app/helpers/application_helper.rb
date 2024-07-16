# frozen_string_literal: true

module ApplicationHelper
  def define_status_class(status)
    case status
    when 'pending'
      'text-blue-700 bg-blue-100 dark:bg-blue-700 dark:text-blue-100'
    when 'failed'
      'text-red-700 bg-red-100 dark:bg-red-800 dark:text-red-600'
    else
      'text-green-700 bg-green-100 dark:bg-green-700 dark:text-green-100'
    end
  end
end
