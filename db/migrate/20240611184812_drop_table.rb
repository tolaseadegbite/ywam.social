class DropTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :event_co_hosts
  end
end
