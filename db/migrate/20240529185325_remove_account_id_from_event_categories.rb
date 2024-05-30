class RemoveAccountIdFromEventCategories < ActiveRecord::Migration[7.1]
  def change
    remove_column :event_categories, :account_id
  end
end
