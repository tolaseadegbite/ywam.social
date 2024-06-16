class AddStatusToEventCoHosts < ActiveRecord::Migration[7.1]
  def change
    add_column :event_co_hosts, :status, :integer, default: 0
  end
end
