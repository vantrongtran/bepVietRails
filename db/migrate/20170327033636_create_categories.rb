class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.integer :left, null: false
      t.integer :right, null: false
      t.string :name, null:false, uniq: true
      t.integer :level, null: false, default: 0
      t.timestamps
    end
  end
end
