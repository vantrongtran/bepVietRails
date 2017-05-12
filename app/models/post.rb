class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  mount_uploader :image, PictureUploader

  has_many :comments, as: :target
  has_many :commentors,-> {distinct}, through: :comments, class_name: User.name, source: :user
  has_many :likes, as: :target
  has_many :post_hashtags, foreign_key: :target_id, class_name: Hashtag::PostHashtag.name
  has_many :hashtags, through: :post_hashtags

  accepts_nested_attributes_for :post_hashtags, allow_destroy: true
  accepts_nested_attributes_for :hashtags,
    reject_if: ->attributes{attributes[:name].blank?}
end
