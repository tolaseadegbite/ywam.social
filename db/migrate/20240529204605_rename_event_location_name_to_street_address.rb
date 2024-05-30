class RenameEventLocationNameToStreetAddress < ActiveRecord::Migration[7.1]
  def change
    rename_column :events, :location, :street_address
  end
end
