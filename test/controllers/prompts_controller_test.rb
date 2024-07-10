require "test_helper"

class PromptsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)

    @prompt = prompts(:one)
  end

  test "should get index" do
    get prompts_url
    assert_response :success
  end

  test "should get new" do
    get new_prompt_url
    assert_response :success
  end

  test "should create prompt" do
    assert_difference("Prompt.count") do
      post prompts_url, params: { prompt: { name: @prompt.name, user_id: @prompt.user_id, value: @prompt.value } }
    end

    assert_redirected_to prompt_url(Prompt.last)
  end

  test "should show prompt" do
    get prompt_url(@prompt)
    assert_response :success
  end

  test "should get edit" do
    get edit_prompt_url(@prompt)
    assert_response :success
  end

  test "should update prompt" do
    patch prompt_url(@prompt), params: { prompt: { name: @prompt.name, user_id: @prompt.user_id, value: @prompt.value } }
    assert_redirected_to prompt_url(@prompt)
  end

  test "should destroy prompt" do
    assert_difference("Prompt.count", -1) do
      delete prompt_url(@prompt)
    end

    assert_redirected_to prompts_url
  end
end
