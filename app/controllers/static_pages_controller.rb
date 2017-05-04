class StaticPagesController < ApplicationController
  def index
    @foods = Food.first 10
    @posts = Post.first 8
  end
end
