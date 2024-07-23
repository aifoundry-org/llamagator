# frozen_string_literal: true

json.array! @test_results, partial: 'test_results/test_result', as: :test_result
