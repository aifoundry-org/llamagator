require "application_system_test_case"

class ModelVersionsTest < ApplicationSystemTestCase
  setup do
    @model_version = model_versions(:one)
  end

  test "visiting the index" do
    visit model_versions_url
    assert_selector "h1", text: "Model versions"
  end

  test "should create model version" do
    visit model_versions_url
    click_on "New model version"

    fill_in "Build name", with: @model_version.build_name
    fill_in "Built on", with: @model_version.built_on
    fill_in "Configuration", with: @model_version.configuration
    fill_in "Description", with: @model_version.description
    fill_in "Model", with: @model_version.model_id
    click_on "Create Model version"

    assert_text "Model version was successfully created"
    click_on "Back"
  end

  test "should update Model version" do
    visit model_version_url(@model_version)
    click_on "Edit this model version", match: :first

    fill_in "Build name", with: @model_version.build_name
    fill_in "Built on", with: @model_version.built_on
    fill_in "Configuration", with: @model_version.configuration
    fill_in "Description", with: @model_version.description
    fill_in "Model", with: @model_version.model_id
    click_on "Update Model version"

    assert_text "Model version was successfully updated"
    click_on "Back"
  end

  test "should destroy Model version" do
    visit model_version_url(@model_version)
    click_on "Destroy this model version", match: :first

    assert_text "Model version was successfully destroyed"
  end
end
