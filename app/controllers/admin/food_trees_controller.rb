class Admin::FoodTreesController < Admin::AdminController
  def index
    @json = C45.new(FoodTargetCondition.all, Condition.all).to_json
  end
end
