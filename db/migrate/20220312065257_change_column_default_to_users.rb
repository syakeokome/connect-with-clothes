class ChangeColumnDefaultToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :is_deleted, from: nil, to: "true", null: false
  end
end
