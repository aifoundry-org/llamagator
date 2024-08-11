# frozen_string_literal: true

json.array! @assertion_results, partial: 'assertion_results/assertion_result', as: :assertion_result
