class Admin::FoodTargetConditionsController < Admin::AdminController
  def create
    @food = Food.find params[:food_id]
    condition = @food.food_target_conditions.create(conditions_params[:food_target_conditions].values)
    add_message_flash :success, t(:created)
    redirect_to admin_foods_path
  end

  def conditions_params
    params.require(:ftc).permit food_target_conditions: [:is_match, food_conditions_attributes: [:condition_detail_id, :is_match]]
  end
end
