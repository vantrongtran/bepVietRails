class Ingredient < ApplicationRecord
  validates :name, presence:  true
  validates :inscription, presence:  true

  has_many :food_ingredients
  has_many :foods, through: :food_ingredients

  mount_uploader :image, PictureUploader
  scope :search_by_name, ->keyword { where "name LIKE ?", "%#{keyword}%" }
end
