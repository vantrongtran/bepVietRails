class FoodIngredient < ApplicationRecord
  belongs_to :food, optional: true
  belongs_to :ingredient, defendant: :destroy

  delegate :name, to: :ingredient
  delegate :image, to: :ingredient
  delegate :inscription, to: :ingredient
end
