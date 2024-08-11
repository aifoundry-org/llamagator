# frozen_string_literal: true

class AssertionResultsController < ApplicationController
  before_action :set_test_result

  def index
    @assertion_results = @test_result.assertion_results
  end

  private

  def set_test_result
    @test_result = current_user.test_results.find(params[:test_result_id])
  end
end
