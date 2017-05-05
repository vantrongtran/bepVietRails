class FoodsController < ApplicationController
  before_action :load_food, only: :show

  def index
    @foods = params[:name] ? (Food.search_by_name( params[:name] ).page(params[:page]).per Settings.per_page.food): (Food.all.page(params[:page]).per Settings.per_page.food)
  end

  def show
    @comment = Comment.new
  end

  private
  def load_food
    @food = Food.find params[:id]
  end
end
