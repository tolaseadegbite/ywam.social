class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.date :start_date
      t.time :start_time
      t.date :end_date
      t.time :end_time
      t.integer :time_zone
      t.text :details
      t.string :location
      t.string :streaming_link

      t.timestamps
    end
  end
end
