class AddImageToIngredients < ActiveRecord::Migration[5.0]
  def change
    add_column :ingredients, :image, :string
  end
end
