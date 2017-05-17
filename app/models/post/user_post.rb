class Post::UserPost < Post

  paginates_per 12

  belongs_to :user, foreign_key: :target_id

  after_create :create_activity

  def self.model_name
    Post.model_name
  end

  private
  def create_activity
    Activity.create action_type: :write, user_id: self.target_id, target: self
  end
end
