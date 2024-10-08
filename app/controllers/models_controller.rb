# frozen_string_literal: true

class ModelsController < ApplicationController
  before_action :set_model, only: %i[show edit update destroy]

  # GET /models or /models.json
  def index
    @models = current_user.models
  end

  # GET /models/1 or /models/1.json
  def show
    @model_versions = @model.model_versions
  end

  # GET /models/new
  def new
    @model = current_user.models.new
    @model_version = @model.model_versions.new
  end

  # GET /models/1/edit
  def edit; end

  # POST /models or /models.json
  def create
    @model = current_user.models.new(model_params)

    respond_to do |format|
      if @model.save
        format.html { redirect_to model_url(@model), notice: 'Model successfully created.' }
        format.json { render :show, status: :created, location: @model }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /models/1 or /models/1.json
  def update
    respond_to do |format|
      if @model.update(model_params)
        format.html { redirect_to model_url(@model), notice: 'Model successfully updated.' }
        format.json { render :show, status: :ok, location: @model }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /models/1 or /models/1.json
  def destroy
    @model.destroy!

    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Model successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_model
    @model = current_user.models.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def model_params
    params.require(:model).permit(:name, :url, :executor_type, :api_key,
                                  model_versions_attributes: %i[id configuration description built_on build_name _destroy])
  end
end
