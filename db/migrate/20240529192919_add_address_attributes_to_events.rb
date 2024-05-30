class AddAddressAttributesToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :country, :string
    add_column :events, :state, :string
    add_column :events, :city, :string
  end
end
