class Hashtag::PostHashtag < TargetHashtag
  belongs_to :post, foreign_key: :target_id, optional: true
end
