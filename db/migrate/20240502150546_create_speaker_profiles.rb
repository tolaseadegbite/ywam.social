class CreateSpeakerProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :speaker_profiles do |t|
      t.string :name
      t.string :link
      t.references :event_speaker, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
