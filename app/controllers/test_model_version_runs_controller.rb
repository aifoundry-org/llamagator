# frozen_string_literal: true

class TestModelVersionRunsController < ApplicationController
  before_action :set_test_run
  before_action :set_test_model_version_run

  # GET /test_model_version_runs/1 or /test_model_version_runs/1.json
  def show
    @test_results = @test_model_version_run.test_results.includes(:assertion_results).decorate
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_test_model_version_run
    @test_model_version_run = @test_run.test_model_version_runs.with_passed_test_results_count.find(params[:id]).decorate
  end

  def set_test_run
    @test_run = current_user.test_runs.find(params[:test_run_id])
  end
end
