class AddCityToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :city, :string
  end
end
