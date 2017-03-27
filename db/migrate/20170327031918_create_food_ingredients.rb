class CreateFoodIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :food_ingredients do |t|
      t.references :food, null: false
      t.references :ingredient, null: false
      t.float :value
      t.timestamps
    end
  end
end
