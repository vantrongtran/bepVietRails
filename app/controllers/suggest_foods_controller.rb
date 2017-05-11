class SuggestFoodsController < ApplicationController
  def index
    if params[:suggest]
      target_conditions = User.new.user_conditions.build condition_params[:user_conditions_attributes].values
      @foods = Food.suggest(target_conditions)
    else
      if user_signed_in?
        @foods = Food.suggest(current_user.user_conditions)
      end
    end
  end

  private
  def condition_params
    params.require(:user).permit user_conditions_attributes: [:condition_detail_id, :is_match]
  end
end
