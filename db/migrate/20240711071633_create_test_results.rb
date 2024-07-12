class CreateTestResults < ActiveRecord::Migration[7.1]
  def change
    create_table :test_results do |t|
      t.references :model_version, null: false, foreign_key: true
      t.references :prompt, null: false, foreign_key: true
      t.text :result
      t.float :time
      t.integer :rating
      t.integer :status

      t.timestamps
    end
  end
end
