class Condition::FoodCondition < TargetCondition
  belongs_to :food, foreign_key: :target_id
  belongs_to :condition_detail

  scope :match, -> is_match{where is_match: is_match}
end
