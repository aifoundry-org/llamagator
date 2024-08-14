# frozen_string_literal: true

class AddModelVersionToAssertions < ActiveRecord::Migration[7.1]
  def change
    add_reference :assertions, :model_version, null: true, foreign_key: true
  end
end
