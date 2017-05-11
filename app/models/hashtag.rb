class Hashtag < ApplicationRecord

  has_many :target_hashtags
  has_many :foods, through: :target_hashtags, source_type: Food.name, source: :target
  has_many :posts, through: :target_hashtags, source_type: Post.name, source: :target
  has_many :ingredients, through: :target_hashtags, source_type: Ingredient.name, source: :target

  validates :name, presence: true, uniqueness: true
  scope :search, -> key {where("name like ?", "%#{key}%") if key.present?}
end
