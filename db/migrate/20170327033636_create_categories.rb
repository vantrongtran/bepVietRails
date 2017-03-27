class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.integer :parent_id
      t.integer :left_id
      t.integer :right_id
      t.string :name, null:false
      t.timestamps
    end
  end
end
