# frozen_string_literal: true

class TestRunsController < ApplicationController
  before_action :set_test_run, only: %i[show]

  # GET /test_runs or /test_runs.json
  def index
    @test_runs = current_user.test_runs.includes(model_versions: :model).all

    @test_runs = @test_runs.where(prompt_id: params[:prompt_id]) if params[:prompt_id].present?
  end

  # GET /test_runs/1 or /test_runs/1.json
  def show
    @test_model_version_runs = @test_run.test_model_version_runs.includes(model_version: :model)
  end

  # GET /test_runs/new
  def new
    @prompt = current_user.prompts.find_by(id: params[:prompt_id])
    @prompts = current_user.prompts
    @model_versions = current_user.model_versions.includes(:model)
    @test_run = current_user.test_runs.new(prompt: @prompt)
  end

  # POST /test_runs or /test_runs.json
  def create
    @test_run = current_user.test_runs.new(test_run_params)

    respond_to do |format|
      if @test_run.save
        TestRunJob.perform_later(@test_run.id)
        format.html { redirect_to test_run_url(@test_run), notice: 'Test model version run was successfully created.' }
        format.json { render :show, status: :created, location: @test_run }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @test_run.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_test_run
    @test_run = current_user.test_runs.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def test_run_params
    params.require(:test_run).permit(:prompt_id, :calls).tap do |permited|
      model_version_ids = params[:test_run][:model_version_ids]&.select(&:present?)
      if model_version_ids.present?
        permited[:test_model_version_runs_attributes] = model_version_ids.map do |model_version_id|
          { model_version_id: }
        end
      end
    end
  end
end
