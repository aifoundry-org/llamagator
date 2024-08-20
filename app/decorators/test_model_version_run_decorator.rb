# frozen_string_literal: true

class TestModelVersionRunDecorator < ApplicationDecorator
  delegate_all

  def passed_percentage
    return if object.test_results.empty? || object.test_results.any?(&:pending?)

    return 0 if test_results_total_count.to_i.zero?

    (passed_test_results_count.to_f / test_results_total_count * 100).round(2)
  end

  def state
    return 'pending' if pending?
    return 'passed' if passed?

    'failed'
  end

  def pending?
    object.test_results.empty? || object.test_results.any?(&:pending?)
  end

  def passed?
    passed_percentage >= object.test_run.passing_threshold
  end
end
