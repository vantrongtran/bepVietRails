class StaticPagesController < ApplicationController
  def index
    @foods = Food.most_rate Settings.per_page.most_rate
    @posts = Post.last 8
  end
end
