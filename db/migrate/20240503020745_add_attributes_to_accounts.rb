class AddAttributesToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :organization_name, :string
    add_column :accounts, :organization_type, :integer, default: 0, null: false
  end
end
