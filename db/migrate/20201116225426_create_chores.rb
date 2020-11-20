class CreateChores < ActiveRecord::Migration
  def change
    create_table :chores do |t|
      t.string :name
      t.integer :parent_id
      t.integer :child_id, null: true
      t.integer :value 
      t.integer :tagged_complete
      
    end
  end
end
