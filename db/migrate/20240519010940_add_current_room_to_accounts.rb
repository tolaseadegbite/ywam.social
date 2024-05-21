class AddCurrentRoomToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :current_account, :integer
  end
end
