# frozen_string_literal: true

class AddAncestryToPrompts < ActiveRecord::Migration[7.1]
  def change
    change_table(:prompts) do |t|
      t.string 'ancestry', collation: 'C'
      t.index 'ancestry'
    end
  end
end
