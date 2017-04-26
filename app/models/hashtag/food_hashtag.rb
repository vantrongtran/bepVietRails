class Hashtag::FoodHashtag < TargetHashtag
  belongs_to :food, foreign_key: :target_id, optional: true
end
