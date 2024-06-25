class AddStatusToEvents < ActiveRecord::Migration[7.1]
  def change
    create_enum :status, %w[
      draft
      published
    ]
    add_column :events, :status, :enum, enum_type: 'status', default: 'draft', null: false
  end
end
