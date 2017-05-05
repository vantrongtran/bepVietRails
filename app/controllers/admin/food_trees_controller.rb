class Admin::FoodTreesController < Admin::AdminController
  def index
      @json = C45.new(Food.all).to_json
  end
end
