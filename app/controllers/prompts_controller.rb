# frozen_string_literal: true

class PromptsController < ApplicationController
  before_action :set_prompt, only: %i[show destroy]

  # GET /prompts or /prompts.json
  def index
    @prompts = current_user.prompts.latest_versions
  end

  # GET /prompts/1 or /prompts/1.json
  def show
    @test_runs = @prompt.test_runs.includes(model_versions: :model).order(created_at: :desc)
  end

  def edit
    @parent_prompt = current_user.prompts.find(params[:id])
    @prompt = current_user.prompts.new
  end

  def update
    parent_prompt = current_user.prompts.find(params[:id])

    @prompt = current_user.prompts.new(prompt_params.merge(parent: parent_prompt))

    respond_to do |format|
      if @prompt.save
        format.html { redirect_to prompt_url(@prompt), notice: 'Prompt was successfully updated.' }
        format.json { render :show, status: :created, location: @prompt }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @prompt.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /prompts/new
  def new
    @prompt = current_user.prompts.new
  end

  # POST /prompts or /prompts.json
  def create
    @prompt = current_user.prompts.new(prompt_params)

    respond_to do |format|
      if @prompt.save
        format.html { redirect_to prompt_url(@prompt), notice: 'Prompt was successfully created.' }
        format.json { render :show, status: :created, location: @prompt }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @prompt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prompts/1 or /prompts/1.json
  def destroy
    @prompt.ancestors.destroy_all
    @prompt.destroy!

    respond_to do |format|
      format.html { redirect_to prompts_url, notice: 'Prompt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_prompt
    @prompt = current_user.prompts.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def prompt_params
    params.require(:prompt).permit(:value, :name)
  end
end
