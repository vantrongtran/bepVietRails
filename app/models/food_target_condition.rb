class FoodTargetCondition < ApplicationRecord
  belongs_to :food

  has_many :food_conditions, foreign_key: :target_id, class_name: Condition::FoodCondition.name
  has_many :condition_details, through: :food_conditions
  has_many :condition, ->{distinct}, through: :condition_details

  accepts_nested_attributes_for :food_conditions,
    reject_if: ->attributes{attributes[:condition_detail_id].blank?}, allow_destroy: true


  scope :in, -> ids { where(id: ids)}

  scope :match_condition, -> condition_id do
    joins(:food_conditions)
      .where(target_conditions: {condition_detail_id: condition_id, is_match: true})
  end
  scope :not_match_condition, -> condition_id do
    joins(:food_conditions)
      .where(target_conditions: {condition_detail_id: condition_id, is_match: false})
  end
  scope :is_match, -> is_match do
    where is_match: is_match
  end
end
