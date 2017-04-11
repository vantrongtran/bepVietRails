class Ingredient < ApplicationRecord
  validates :name, presence:  true
  validates :inscription, presence:  true
  mount_uploader :image, PictureUploader
end
