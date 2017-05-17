class Rate < ActiveRecord::Base
  belongs_to :rater, class_name: User.name
  belongs_to :rateable, :polymorphic => true

  after_create :create_activity
  #attr_accessible :rate, :dimension
  private
  def create_activity
    Activity.create action_type: :rate, user_id: self.rater_id, target: self.rateable
  end
end
