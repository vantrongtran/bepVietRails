class Condition < ApplicationRecord
  has_many :condition_details, dependent: :destroy
  has_many :target_conditions, through: :condition_details, dependent: :destroy
  has_many :food_conditions, through: :condition_details, dependent: :destroy
  has_many :food_target_conditions, ->{distinct}, through: :food_conditions, dependent: :destroy
end
