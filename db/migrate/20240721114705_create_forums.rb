class CreateForums < ActiveRecord::Migration[7.1]
  def change
    create_table :forums do |t|
      t.string :name
      t.text :description
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
