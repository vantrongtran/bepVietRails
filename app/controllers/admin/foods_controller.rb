class Admin::FoodsController < Admin::AdminController
  before_action :load_food, only: [:edit, :update, :destroy]

  def index
    if params[:ingredient]
      @ingredients = Ingredient.search_by_name params[:ingredient]
    else
      @food = Food.new
      @foods = Food.name_like(params[:keyword]).page(params[:page])
    end
  end

  def create
    @food = Food.new food_params
    if @food.save
      add_message_flash :success, t(:created)
    else
      add_message_flash :error, t(:created_fail)
      add_message_flash :error, @food.errors.full_messages
    end
    redirect_to admin_foods_path
  end

  def edit
  end

  def update
    if @food.update_attributes food_params
      add_message_flash :success, t(:updated)
    else
      add_message_flash :error, t(:updated_fail)
    end
    redirect_to admin_foods_path
  end

  def destroy
    if @food.destroy
      add_message_flash :success, t(:deleted)
    else
      add_message_flash_now :error, t(:failed)
    end
    redirect_to admin_foods_path
  end

  private
  def load_food
    @food = Food.includes(:ingredients, food_hashtags: :hashtag).find(params[:id])
  end

  def food_params
    params.require(:food).permit :name, :image, :calorie, :cooking_method, food_ingredients_attributes: [:id, :ingredient_id, :value, :_destroy],
      food_hashtags_attributes: [:id, :hashtag_id, :_destroy], hashtags_attributes: [:name], food_conditions_attributes: [:id, :condition_detail_id, :_destroy, :is_mathch]
  end
end
