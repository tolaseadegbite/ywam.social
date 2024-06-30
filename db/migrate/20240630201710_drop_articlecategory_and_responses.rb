class DropArticlecategoryAndResponses < ActiveRecord::Migration[7.1]
  def change
    drop_table :article_categories
    drop_table :responses
    remove_column :articles, :article_category_id
  end
end
