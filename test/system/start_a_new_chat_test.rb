require "application_system_test_case"

class StartANewChatTest < ApplicationSystemTestCase
  test "new chat page can create a chat with a title" do
    visit new_chat_url
  
    fill_in "Title", with: "A new chat"

    click_on "Create Chat"

    assert_text "Chat was successfully created."
    assert_current_path chat_path(Chat.last.id)
  end
end
