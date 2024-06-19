class AddUniqueIndexToEventCoHosts < ActiveRecord::Migration[7.1]
  def change
    add_index :event_co_hosts, [:event_id, :account_id], unique: true
  end
end
