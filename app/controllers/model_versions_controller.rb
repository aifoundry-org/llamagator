# frozen_string_literal: true

class ModelVersionsController < ApplicationController
  before_action :set_model
  before_action :set_model_version, only: %i[show edit update destroy]

  # GET /model_versions or /model_versions.json
  def index
    @model_versions = @model.model_versions
  end

  # GET /model_versions/1 or /model_versions/1.json
  def show; end

  # GET /model_versions/new
  def new
    @model_version = @model.model_versions.new
  end

  # GET /model_versions/1/edit
  def edit; end

  # POST /model_versions or /model_versions.json
  def create
    @model_version = @model.model_versions.new(model_version_params)

    respond_to do |format|
      if @model_version.save
        format.html do
          redirect_to model_model_version_url(@model, @model_version), notice: 'Model version was successfully created.'
        end
        format.json { render :show, status: :created, location: model_model_version_url(@model, @model_version) }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @model_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /model_versions/1 or /model_versions/1.json
  def update
    respond_to do |format|
      if @model_version.update(model_version_params)
        format.html do
          redirect_to model_model_version_url(@model, @model_version), notice: 'Model version was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @model_version }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @model_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /model_versions/1 or /model_versions/1.json
  def destroy
    @model_version.destroy!

    respond_to do |format|
      format.html { redirect_to model_model_versions_url(@model), notice: 'Model version was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_model_version
    @model_version = @model.model_versions.find(params[:id])
  end

  def set_model
    @model = current_user.models.find(params[:model_id])
  end

  # Only allow a list of trusted parameters through.
  def model_version_params
    params.require(:model_version).permit(:configuration, :description, :built_on, :build_name)
  end
end
