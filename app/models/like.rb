class Like < ApplicationRecord
  belongs_to :user
  belongs_to :target, polymorphic: true

  after_create :create_activity

  private
  def create_activity
    activity = Activity.find_or_initialize_by action_type: :like, user_id: self.user_id, target: self.target
    activity.updated_at = Time.zone.now
    activity.save
  end
end
