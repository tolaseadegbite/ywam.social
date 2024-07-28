class AddFollowsCountToDiscussions < ActiveRecord::Migration[7.1]
  def change
    add_column :discussions, :follows_count, :integer, default: 0, null: false
  end
end
