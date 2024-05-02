class AddCostTypeToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :cost_type, :integer
  end
end
