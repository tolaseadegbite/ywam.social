class CreateRsvps < ActiveRecord::Migration[7.1]
  def change
    create_table :rsvps do |t|
      t.references :account, null: false, foreign_key: true
      t.references :rsvpable, polymorphic: true, null: false
      t.string :status

      t.timestamps
    end
  end
end
