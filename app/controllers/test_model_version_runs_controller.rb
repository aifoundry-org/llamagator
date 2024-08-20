# frozen_string_literal: true

class TestModelVersionRunsController < ApplicationController
  before_action :set_test_run
  before_action :set_test_model_version_run

  # GET /test_model_version_runs/1 or /test_model_version_runs/1.json
  def show
    @test_results = @test_model_version_run.test_results.includes(:assertion_results).decorate
  end

  # POST /test_runs/1/test_model_version_runs/2/perform or /test_runs/1/test_model_version_runs/2/perform.json
  def perform
    respond_to do |format|
      if @test_model_version_run.state == 'pending'
        perform_all_test_model_version_run_jobs

        notice = 'Test model version run was successfully performed.'
        format.html { redirect_to perform_test_run_test_model_version_run_path(@test_run, @test_model_version_run), notice: }
        format.json { render :show, status: :created }
      else
        # TODO: render errors
      end
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

  def perform_all_test_model_version_run_jobs
    jobs = Array.new(@test_run.calls) { TestModelVersionRunJob.new(@test_model_version_run.id) }
    ActiveJob.perform_all_later(jobs)
  end
end
