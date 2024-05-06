class ChangeAccountNullAttributesToTrue < ActiveRecord::Migration[7.1]
  def change
    change_column_null :accounts, :firstname, true
    change_column_null :accounts, :surname, true
  end
end
