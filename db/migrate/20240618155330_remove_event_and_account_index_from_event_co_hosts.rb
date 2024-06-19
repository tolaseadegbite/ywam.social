class RemoveEventAndAccountIndexFromEventCoHosts < ActiveRecord::Migration[7.1]
  def change
    remove_index :event_co_hosts, name: "index_event_co_hosts_on_event_id_and_account_id"
  end
end
