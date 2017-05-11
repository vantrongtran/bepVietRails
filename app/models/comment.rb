class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :target, polymorphic: true
  has_many :likes, as: :target
end
