class RenameEventsTimeZoneColumnType < ActiveRecord::Migration[7.1]
  def change
    remove_column :events, :time_zone
    add_column :events, :time_zone, :string
  end
end
