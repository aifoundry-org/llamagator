class CreateModelVersions < ActiveRecord::Migration[7.1]
  def change
    create_table :model_versions do |t|
      t.references :model, null: false, foreign_key: true
      t.json :configuration
      t.text :description
      t.date :built_on
      t.string :build_name

      t.timestamps
    end
  end
end
