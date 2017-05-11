class TargetHashtag < ApplicationRecord
  belongs_to :hashtag
  belongs_to :target, polymorphic: true

  delegate :name, to: :hashtag
end
