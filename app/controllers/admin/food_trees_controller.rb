class Admin::FoodTreesController < Admin::AdminController
  def index
      @json = C45.new(FoodTargetCondition.all).to_json
  end
end
