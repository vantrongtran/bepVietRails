class Admin::CategoriesController < ApplicationController
  before_action :load_category, [:edit, :update, :destroy]

  def index
    Category.all
  end

  def edit
  end

  def update
  end

  def destroy

  end

  private
  def category_params
    params.require(:category).permit :name
  end

  def load_category
    Category.find_by params[:id]
  end
end
