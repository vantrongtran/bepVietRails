class Condition::UserCondition < TargetCondition
  belongs_to :user, foreign_key: :target_id, dependent: :destroy, optional: true

end
