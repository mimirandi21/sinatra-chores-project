class CreateChores < ActiveRecord::Migration
  def change
    create_table :chores do |t|
      t.string :name
      t.integer :parent_id
      t.integer :child_id, null: true
      t.float :value 
      t.integer :tagged_complete
      t.timestamps null: false
    end
  end
end
