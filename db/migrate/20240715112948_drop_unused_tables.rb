class DropUnusedTables < ActiveRecord::Migration[7.1]
  def up
    drop_table :messages
    drop_table :chats
    drop_table :participants
  end

  def down
    create_table :chats do |t|
      t.string :title

      t.timestamps
    end

    create_table :messages do |t|
      t.text :body
      t.string :from
      t.references :chat

      t.timestamps
    end

    create_table :participants do |t|
      t.string :name
      t.text :configuration
      t.string :implementor

      t.timestamps
    end
  end
end
