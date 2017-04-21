class StaticPagesController < ApplicationController
  def index
    @foods = Food.first 6
  end
end
