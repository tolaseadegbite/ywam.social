class AddResponsesCountToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :responses_count, :integer, default: 0
  end
end
