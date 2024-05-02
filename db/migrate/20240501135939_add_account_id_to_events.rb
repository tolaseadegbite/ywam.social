class AddAccountIdToEvents < ActiveRecord::Migration[7.1]
  def change
    add_reference :events, :account, null: false, foreign_key: true
  end
end
