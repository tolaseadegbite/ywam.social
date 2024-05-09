class RemoveAccountAddressAttributesFromAccounts < ActiveRecord::Migration[7.1]
  def change
    remove_column :accounts, :country, :string
    remove_column :accounts, :city, :string
    remove_column :accounts, :state, :string
  end
end
