class Post::UserPost < Post
  belongs_to :user, foreign_key: :target_id
  def self.model_name
    Post.model_name
  end
end
