class StaticPagesController < ApplicationController
  def index
    @foods = Food.most_rate(Settings.per_page.most_rate)
    @tips = Post::Tip.last 8
  end
end
