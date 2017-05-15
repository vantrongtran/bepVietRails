class Post::Tip < Post

  paginates_per 12

  belongs_to :category, foreign_key: :target_id

  scope :of_categor, -> category_id{ where target_id: category_id if category_id.present?}

  def self.model_name
    Post.model_name
  end
end
