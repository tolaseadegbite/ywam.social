class CreateEventTalks < ActiveRecord::Migration[7.1]
  def change
    create_table :event_talks do |t|
      t.string :title
      t.text :description
      t.references :account, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.references :event_speaker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
