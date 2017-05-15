class HashtagsController < ApplicationController
  def index
    @hashtags = Hashtag.search(params[:hashtag]).first(8)
  end

  def show
    begin
      @tag = Hashtag.find params[:id]
    rescue
      @tag = Hashtag.find_by name: params[:id]
    end
    @foods = @tag.foods.page(params[:foods_page]).per 8
    @posts = @tag.posts.page(params[:posts_page]).per 8
    @ingredients = @tag.ingredients.page(params[:ingredient_page]).per 8
  end
end
