class Admin::FoodsController < Admin::AdminController
  def index
    @food = Food.new
    @foods = Food.all
  end

  def create
    @food = Food.new
  end

  def edit

  end

  private

  def food_params

  end
end
