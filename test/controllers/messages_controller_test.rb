require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @message = messages(:one)
    @chat = @message.chat
  end

  test "should get index" do
    get chat_messages_url(@chat)
    assert_response :success
  end

  test "should get new" do
    get new_chat_message_url(@chat)
    assert_response :success
  end

  test "should create message" do
    assert_difference("Message.count") do
      post chat_messages_url(@chat), params: { message: { body: @message.body } }
    end

    assert_redirected_to chat_message_url(@chat, Message.last)
  end

  test "should show message" do
    get chat_message_url(@chat, @message)
    assert_response :success
  end

  test "should get edit" do
    get edit_chat_message_url(@chat, @message)
    assert_response :success
  end

  test "should update message" do
    patch chat_message_url(@chat, @message), params: { message: { body: @message.body } }
    assert_redirected_to chat_message_url(@chat, @message)
  end

  test "should destroy message" do
    assert_difference("Message.count", -1) do
      delete chat_message_url(@chat, @message)
    end

    assert_redirected_to chat_messages_url(@chat)
  end
end
