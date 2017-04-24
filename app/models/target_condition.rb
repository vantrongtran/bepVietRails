class TargetCondition < ApplicationRecord
  belongs_to :condition_detail, dependent: :destroy
  belongs_to :condition, dependent: :destroy
end
