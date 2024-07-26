class AddLikesCountToDiscussions < ActiveRecord::Migration[7.1]
  def change
    add_column :discussions, :likes_count, :integer, default: 0, null: false
  end
end
