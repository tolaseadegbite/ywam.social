class RenameEventCatrgoryToArticleCategoryName < ActiveRecord::Migration[7.1]
  def change
    rename_column :articles, :event_category_id, :article_category_id
  end
end
