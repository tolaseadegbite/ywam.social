class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :saves_count, default: 0, null: false
      t.integer :likes_count, default: 0, null: false
      t.references :account, null: false, foreign_key: true
      t.references :event_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
