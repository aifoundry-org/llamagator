# frozen_string_literal: true

class CreateModels < ActiveRecord::Migration[7.1]
  def change
    create_table :models do |t|
      t.string :name
      t.string :url
      t.references :user

      t.timestamps
    end
  end
end
