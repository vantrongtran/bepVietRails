class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  mount_uploader :image, PictureUploader
end
