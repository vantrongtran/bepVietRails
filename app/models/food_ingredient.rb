class FoodIngredient < ApplicationRecord
  belongs_to :food, optional: true
  belongs_to :ingredient

  delegate :name, to: :ingredient
  delegate :image, to: :ingredient
end
