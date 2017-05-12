class SearchController < ApplicationController
  def index
    if params[:keyword] && params[:type]
      @posts = []
      @foods = []
      @ingredients = []
      types = params[:type].values
      @results = Search.new.search params[:keyword], types
      @results.each do |r|
        if Food === r.first
          @foods << r.first
        elsif Post === r.first
          @posts << r.first
        else
          @ingredients << r.first
        end
      end
    end
    @foods
    @posts
    @ingredients
  end
end
