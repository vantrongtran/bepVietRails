class TargetHashtag < ApplicationRecord
  belongs_to :hashtag

  delegate :name, to: :hashtag
end
