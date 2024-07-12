class AddApiKeyToModels < ActiveRecord::Migration[7.1]
  def change
    add_column :models, :api_key, :string
  end
end
