class Admin::FoodsController < Admin::AdminController
  before_action :load_food, only: [:edit, :update, :destroy]

  def index
    @food = Food.new
    @foods = Food.all
    @ingredients = Ingredient.search_by_name params[:ingredient] if params[:ingredient]
  end

  def create
    @food = Food.new food_params
    if @food.save
      @food.ingredient_ids = foods_params[:ingredients].keys
      add_message_flash :success, t(:created)
    else
      add_message_flash_now :error, t(:failed)
    end
    redirect_to admin_foods_path
  end

  def edit

  end

  def update

  end

  def destroy
    if @food.destroy
      add_message_flash :success, t(:deleted)
    else
      add_message_flash_now :error, t(:failed)
    end
    redirect_to admin_ingredients_path
  end

  private
  def load_food
    @food = Food.find_by params[:id]
  end

  def foods_params
    params.require(:food).permit :name, :image, :calorie, :cooking_method, ingredients: [:ingredient_id, :ingredient_value]
  end

  def food_params
    params.require(:food).permit :name, :image, :calorie, :cooking_method
  end
end
