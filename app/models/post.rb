class Post < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  mount_uploader :image, PictureUploader

  has_many :comments, as: :target
  has_many :commentors,-> {distinct}, through: :comments, class_name: User.name, source: :user
  has_many :likes, as: :target
  has_many :post_hashtags, as: :target, class_name:TargetHashtag.name
  has_many :hashtags, through: :post_hashtags

  accepts_nested_attributes_for :post_hashtags, allow_destroy: true
  accepts_nested_attributes_for :hashtags,
    reject_if: ->attributes{attributes[:name].blank?}

  scope :of_hashtag, ->tag{joins(:hashtags).where(hashtags: {name: tag})}
  # scope :name_like, ->keyword do
  #   (where("posts.title LIKE ?", "%#{keyword}%") | of_hashtag(keyword)) if keyword.present?
  # end
  scope :name_like, ->keyword do
    join_sql = <<-SQL
      LEFT JOIN target_hashtags ON target_hashtags.target_id = posts.id AND target_hashtags.target_type = 'Post'
      LEFT JOIN hashtags ON hashtags.id = target_hashtags.hashtag_id
    SQL
    joins(join_sql)
      .where("posts.title LIKE ? OR hashtags.name = ?", "%#{keyword}%", keyword) if keyword.present?
  end
end
