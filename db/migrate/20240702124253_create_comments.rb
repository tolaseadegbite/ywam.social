class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :account, null: false, foreign_key: true
      t.text :body
      t.references :commentable, polymorphic: true, null: false
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :comments, :deleted_at
  end
end
