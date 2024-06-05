require "application_system_test_case"

class ChatsTest < ApplicationSystemTestCase
  setup do
    @chat = chats(:one)
  end

  test "visiting the index" do
    visit chats_url
    assert_selector "h1", text: "Chats"
  end

  test "should create chat" do
    visit chats_url
    click_on "New chat"

    fill_in "Title", with: @chat.title
    click_on "Create Chat"

    assert_text "Chat was successfully created"
    click_on "Back"
  end

  test "should update Chat" do
    visit chat_url(@chat)
    click_on "Edit this chat", match: :first

    fill_in "Title", with: @chat.title
    click_on "Update Chat"

    assert_text "Chat was successfully updated"
    click_on "Back"
  end

  test "should destroy Chat" do
    visit chat_url(@chat)
    click_on "Destroy this chat", match: :first

    assert_text "Chat was successfully destroyed"
  end
end
