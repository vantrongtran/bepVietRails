class ConditionDetail < ApplicationRecord
  has_many :target_conditions, dependent: :destroy
  has_many :food_conditions, foreign_key: :target_id, class_name: Condition::FoodCondition.name, dependent: :destroy
  has_many :food_target_conditions, through: :food_conditions, class_name: FoodTargetCondition.name, dependent: :destroy

  belongs_to :condition

  def name
    return self.value
  end
end
