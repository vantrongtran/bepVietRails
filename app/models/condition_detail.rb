class ConditionDetail < ApplicationRecord
  has_many :target_conditions
  has_many :food_conditions, foreign_key: :target_id, class_name: Condition::FoodCondition.name
  has_many :food_target_conditions, through: :food_conditions, class_name: FoodTargetCondition.name

  belongs_to :condition
end
