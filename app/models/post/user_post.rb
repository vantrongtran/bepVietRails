class Post::UserPost < Post

  paginates_per 12

  belongs_to :user, foreign_key: :target_id
  def self.model_name
    Post.model_name
  end
end
