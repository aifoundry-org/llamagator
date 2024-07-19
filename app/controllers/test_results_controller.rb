# frozen_string_literal: true

class TestResultsController < ApplicationController
  before_action :set_test_result, only: %i[show update]

  def update
    if @test_result.update(test_results_params)
      render json: { success: true, rating: @test_result.rating }, status: :ok
    else
      render json: { success: false, errors: @test_result.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    @test_results = current_user.test_results.includes(test_model_version_run: { model_version: :model }).order(created_at: :desc)

    if params[:model_version_id].present? && params[:test_run_id].present?
      @test_results = @test_results.joins(:test_model_version_run).where(test_model_version_runs: { model_version_id: params[:model_version_id], test_run_id: params[:test_run_id] })
    end

    @test_results = @test_results.where(status: params[:status]) if params[:status].present?

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @test_results }
    end
  end

  def show; end

  private

  def set_test_result
    @test_result = current_user.test_results.find(params[:id])
  end

  def test_results_params
    params.require(:test_result).permit(:rating)
  end
end
