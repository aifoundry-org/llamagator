# frozen_string_literal: true

class CreatePrompts < ActiveRecord::Migration[7.1]
  def change
    create_table :prompts do |t|
      t.references :user, null: false, foreign_key: true
      t.text :value
      t.string :name

      t.timestamps
    end
  end
end
