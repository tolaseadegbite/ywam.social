class CreateEventSpeakers < ActiveRecord::Migration[7.1]
  def change
    create_table :event_speakers do |t|
      t.string :name
      t.text :about
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
