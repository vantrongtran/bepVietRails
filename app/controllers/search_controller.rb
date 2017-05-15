class SearchController < ApplicationController
  def index
    types = []
    if params[:keyword].present? && params[:type]
      types = params[:type].values

    elsif params[:keyword].present?
      types = [Food.name, Post::Tip.name, Ingredient.name]
    end
    @results = []
    types.each do |type|
      result = []
      begin
        result = Object.const_get(type).name_like(params[:keyword]).page(params[:"#{type.downcase.tr(":", "")}_page"] || 1)
      rescue
      end
      @results << result if result.any?
    end
  end
end
