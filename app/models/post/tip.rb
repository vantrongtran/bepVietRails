class Post::Tip < Post

  paginates_per 12

  belongs_to :category, foreign_key: :target_id

  def self.model_name
    Post.model_name
  end
end
