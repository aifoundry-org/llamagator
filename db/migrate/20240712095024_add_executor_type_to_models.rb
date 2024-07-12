class AddExecutorTypeToModels < ActiveRecord::Migration[7.1]
  def change
    add_column :models, :executor_type, :integer
  end
end
