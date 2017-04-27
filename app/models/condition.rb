class Condition < ApplicationRecord
  has_many :condition_details
  has_many :target_conditon, through: :condition_details
  has_many :foods, ->{distinct}, through: :condition_details
end
