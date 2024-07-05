class AllowNullDescriptionInResources < ActiveRecord::Migration[7.1]
  def change
    change_column_null :resources, :description, false
  end
end
