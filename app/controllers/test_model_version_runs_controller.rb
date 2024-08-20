# frozen_string_literal: true

class TestModelVersionRunsController < ApplicationController
  before_action :set_test_run
  before_action :set_test_model_version_run, only: :show

  # GET /test_model_version_runs/1 or /test_model_version_runs/1.json
  def show
    @test_results = @test_model_version_run.test_results.includes(:assertion_results).decorate
  end

  # POST /test_runs/1/test_model_version_runs/2/perform or /test_runs/1/test_model_version_runs/2/perform.json
  def perform
    message = if perform_test_model_version_run_jobs
                { alert: 'Test model version run has already been performed.' }
              else
                { notice: 'Test model version run was successfully performed.' }
              end

    respond_to do |format|
      format.html do
        redirect_to perform_test_run_test_model_version_run_path(params[:test_run_id], params[:id]), **message
      end
      format.json { render :show, status: :unprocessable_entity }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_test_model_version_run
    @test_model_version_run = @test_run.test_model_version_runs.with_passed_test_results_count.find(params[:id]).decorate
  end

  def set_test_run
    @test_run = current_user.test_runs.find(params[:test_run_id])
  end

  def perform_test_model_version_run_jobs
    PerformTestModelVersionRunJobs.new(@test_run, params[:id]).call
  end
end
