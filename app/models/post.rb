class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  mount_uploader :image, PictureUploader

  has_many :comments, as: :target
end
