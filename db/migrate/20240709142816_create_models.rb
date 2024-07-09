class CreateModels < ActiveRecord::Migration[7.1]
  def change
    create_table :models do |t|
      t.string :name
      t.string :url
      t.json :configuration
      t.references :user

      t.timestamps
    end
  end
end
