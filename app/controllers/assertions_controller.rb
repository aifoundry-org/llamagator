# frozen_string_literal: true

class AssertionsController < ApplicationController
  before_action :set_assertion, only: %i[show edit update destroy]

  # GET /assertions or /assertions.json
  def index
    @assertions = current_user.assertions.all
  end

  # GET /assertions/1 or /assertions/1.json
  def show; end

  # GET /assertions/new
  def new
    @assertion = current_user.assertions.new
  end

  # GET /assertions/1/edit
  def edit; end

  # POST /assertions or /assertions.json
  def create
    @assertion = current_user.assertions.new(assertion_params)

    respond_to do |format|
      if @assertion.save
        format.html { redirect_to assertion_url(@assertion), notice: 'Assertion was successfully created.' }
        format.json { render :show, status: :created, location: @assertion }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @assertion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assertions/1 or /assertions/1.json
  def update
    respond_to do |format|
      if @assertion.update(assertion_params)
        format.html { redirect_to assertion_url(@assertion), notice: 'Assertion was successfully updated.' }
        format.json { render :show, status: :ok, location: @assertion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @assertion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assertions/1 or /assertions/1.json
  def destroy
    @assertion.destroy!

    respond_to do |format|
      format.html { redirect_to assertions_url, notice: 'Assertion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_assertion
    @assertion = current_user.assertions.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def assertion_params
    params.require(:assertion).permit(:name, :assertion_type, :value, :user_id)
  end
end
