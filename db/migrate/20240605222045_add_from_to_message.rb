class AddFromToMessage < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :from, :string, default: :user
  end
end
