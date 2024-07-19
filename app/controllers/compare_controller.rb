# frozen_string_literal: true

class CompareController < ApplicationController
  def index
    @prompts = current_user.prompts
    @model_versions = current_user.model_versions.includes(:model)
  end

  def model_versions
    @model_versions = current_user.model_versions.joins(test_model_version_runs: :test_results).where(test_model_version_runs: { test_run_id: params[:test_run_id],
                                                                                                                                 test_results: { status: 'completed' } }).uniq

    render json: @model_versions
  end
end
