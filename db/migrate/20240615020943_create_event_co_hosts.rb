class CreateEventCoHosts < ActiveRecord::Migration[7.1]
  def change
    create_table :event_co_hosts do |t|
      t.references :event, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.integer :role, default: 1

      t.timestamps
    end
  end
end
