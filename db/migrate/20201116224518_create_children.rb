class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :name
      t.string :password_digest
      t.integer :parent_id
      t.float :balance, null: true
      t.timestamps null: false
    end
  end
end
