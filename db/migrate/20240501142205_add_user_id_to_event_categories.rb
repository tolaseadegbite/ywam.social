class AddUserIdToEventCategories < ActiveRecord::Migration[7.1]
  def change
    add_reference :event_categories, :user, null: false, foreign_key: true
  end
end
