# frozen_string_literal: true

class TestModelVersionRunJobsController < ApplicationController
  before_action :set_test_run

  # POST /test_runs/1/test_model_version_runs/2/jobs or /test_runs/1/test_model_version_runs/2/jobs.json
  def create
    redirect_path = test_run_test_model_version_run_path(params[:test_run_id], params[:test_model_version_run_id])
    message = if perform_test_model_version_run_jobs
                { notice: 'Test model version run was successfully performed.' }
              else
                { alert: 'Test model version run has already been performed.' }
              end

    respond_to do |format|
      format.html { redirect_to redirect_path, **message }
      # TODO: format.json { ... }
    end
  end

  private

  def set_test_run
    @test_run = current_user.test_runs.find(params[:test_run_id])
  end

  def perform_test_model_version_run_jobs
    PerformTestModelVersionRunJobs.new(@test_run, params[:test_model_version_run_id]).call
  end
end
