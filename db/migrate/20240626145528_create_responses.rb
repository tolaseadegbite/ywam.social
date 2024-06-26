class CreateResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :responses do |t|
      t.references :account, null: false, foreign_key: true
      t.references :responseable, polymorphic: true, null: false

      t.timestamps
    end

    add_index :responses, [:account_id, :responseable_id], unique: true
    add_index :responses, [:account_id, :responseable_id, :responseable_type], unique: true
  end
end
