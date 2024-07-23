# frozen_string_literal: true

class TestModelVersionRunDecorator < ApplicationDecorator
  delegate_all

  def passed_percentage
    return 0 if test_results_total_count.to_i.zero?

    (passed_test_results_count.to_f / test_results_total_count * 100).round(2)
  end
end
