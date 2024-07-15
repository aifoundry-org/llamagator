# frozen_string_literal: true

class CreateParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :participants do |t|
      t.string :name
      t.text :configuration
      t.string :implementor

      t.timestamps
    end
  end
end
