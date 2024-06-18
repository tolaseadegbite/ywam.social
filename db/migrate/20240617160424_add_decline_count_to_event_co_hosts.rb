class AddDeclineCountToEventCoHosts < ActiveRecord::Migration[7.1]
  def change
    add_column :event_co_hosts, :decline_count, :integer, default: 0
  end
end
