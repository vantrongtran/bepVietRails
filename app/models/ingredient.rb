class Ingredient < ApplicationRecord
  validates :name, presence:  true
  validates :inscription, presence:  true

  has_many :food_ingredients, dependent: :destroy
  has_many :foods, through: :food_ingredients

  mount_uploader :image, PictureUploader
  scope :name_like, ->keyword { where "name LIKE ?", "%#{keyword}%" }
end
