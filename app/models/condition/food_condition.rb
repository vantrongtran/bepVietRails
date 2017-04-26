class Condition::FoodCondition < TargetCondition
  belongs_to :food, foreign_key: :target_id, dependent: :destroy, optional: true

  scope :match, -> is_match{where is_match: is_match}
end
