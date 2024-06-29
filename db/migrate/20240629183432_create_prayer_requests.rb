class CreatePrayerRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :prayer_requests do |t|
      t.string :title, null: false
      t.text :description
      t.references :account, null: false, foreign_key: true
      t.integer :saves_count, default: 0, null: false

      t.timestamps
    end
  end
end
