class Admin::FoodsController < Admin::AdminController
  def index
    @food = Food.new
    @foods = Food.all
  end
end
