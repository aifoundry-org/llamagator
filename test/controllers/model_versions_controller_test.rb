require "test_helper"

class ModelVersionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)

    @model = models(:one)
    @model_version = model_versions(:one)
  end

  test "should get index" do
    get model_model_versions_url(@model)
    assert_response :success
  end

  test "should get new" do
    get new_model_model_version_url(@model)
    assert_response :success
  end

  test "should create model_version" do
    assert_difference("ModelVersion.count") do
      post model_model_versions_url(@model), params: { model_version: { build_name: @model_version.build_name, built_on: @model_version.built_on, configuration: @model_version.configuration, description: @model_version.description, model_id: @model_version.model_id } }
    end

    assert_redirected_to model_model_version_url(@model, ModelVersion.last)
  end

  test "should show model_version" do
    get model_model_version_url(@model, @model_version)
    assert_response :success
  end

  test "should get edit" do
    get edit_model_model_version_url(@model, @model_version)
    assert_response :success
  end

  test "should update model_version" do
    patch model_model_version_url(@model, @model_version), params: { model_version: { build_name: @model_version.build_name, built_on: @model_version.built_on, configuration: @model_version.configuration, description: @model_version.description, model_id: @model_version.model_id } }
    assert_redirected_to model_model_version_url(@model, @model_version)
  end

  test "should destroy model_version" do
    assert_difference("ModelVersion.count", -1) do
      delete model_model_version_url(@model, @model_version)
    end

    assert_redirected_to model_model_versions_url(@model)
  end
end
