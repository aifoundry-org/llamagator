# frozen_string_literal: true

class AddChatRefToMessages < ActiveRecord::Migration[7.1]
  def change
    add_reference :messages, :chat, null: false, foreign_key: true
  end
end
