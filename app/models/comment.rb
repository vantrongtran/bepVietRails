class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :target, polymorphic: true
  has_many :likes, as: :target, dependent: :destroy

  after_create :send_notification

  validates :content, presence: true

  private
  def send_notification
    if target.is_a? Post
      users = self.target.commentors
      users.each do |u|
        UserNotifierMailer.send_email_notifier_comment(u, self.target).deliver_later unless u == self.user
      end
      if self.target.is_a?(Post::UserPost) && !users.include?(self.user)
        UserNotifierMailer.send_email_notifier_comment(self.user, self.target).deliver_later
      end
    end
  end
end
