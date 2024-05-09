class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.references :account, null: false, foreign_key: true
      t.string :country
      t.string :state
      t.string :city

      t.timestamps
    end
  end
end
