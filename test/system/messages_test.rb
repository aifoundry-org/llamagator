require "application_system_test_case"

class MessagesTest < ApplicationSystemTestCase
  setup do
    @message = messages(:one)
    @chat = @message.chat

    sign_in users(:one)
  end

  test "visiting the index" do
    visit chat_messages_url(@chat)
    assert_selector "h1", text: "Messages"
  end

  test "should update Message" do
    visit chat_message_url(@chat, @message)
    click_on "Edit this message", match: :first

    fill_in "Body", with: @message.body
    click_on "Update Message"

    assert_text "Message was successfully updated"
    click_on "Back"
  end

  test "should destroy Message" do
    visit chat_message_url(@chat, @message)
    click_on "Destroy this message", match: :first

    assert_text "Message was successfully destroyed"
  end
end
