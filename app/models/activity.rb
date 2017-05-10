class Activity < ApplicationRecord
  enum activity_types: [:follow, :unfollow, :ate, :like, :unlike, :posts]

end
