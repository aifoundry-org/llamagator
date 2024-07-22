# frozen_string_literal: true

class CreateAssertions < ActiveRecord::Migration[7.1]
  def change
    create_table :assertions do |t|
      t.string :name
      t.integer :assertion_type
      t.text :value
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
