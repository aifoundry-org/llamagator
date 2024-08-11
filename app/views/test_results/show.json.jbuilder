# frozen_string_literal: true

json.partial! 'test_results/test_result', test_result: @test_result
json.assertion_results @test_result.assertion_result_ids
