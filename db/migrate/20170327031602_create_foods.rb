class CreateFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :foods do |t|
      t.string :name, null: false
      t.text :cooking_method
      t.float :calorie
      t.timestamps
    end
  end
end
