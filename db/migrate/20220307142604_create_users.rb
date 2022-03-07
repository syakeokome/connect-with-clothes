class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :user_image
      t.string :name
      t.string :self_introduction
      t.string :email
      t.string :password
      t.string :postal_code
      t.string :address
      t.integer :age
      t.integer :height
      t.boolean :is_deleted

      t.timestamps
    end
  end
end
