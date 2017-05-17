class Activity < ApplicationRecord
  enum action_types: [:follow, :unfollow, :rate, :like, :unlike, :write, :comment]

  default_scope {order(updated_at: :desc)}

  belongs_to :target, polymorphic: true
  belongs_to :user
end
