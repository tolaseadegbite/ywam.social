class CreateBookmarks < ActiveRecord::Migration[7.1]
  def change
    create_table :bookmarks do |t|
      t.references :account, null: false, foreign_key: true
      t.references :bookmarkable, polymorphic: true, null: false

      t.timestamps
    end

    add_index :bookmarks, [:account_id, :bookmarkable_type, :bookmarkable_id], unique: true
    add_index :bookmarks, [:bookmarkable_type, :bookmarkable_id]
  end
end
