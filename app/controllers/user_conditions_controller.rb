class UserConditionsController < ApplicationController
  def create
    if current_user.update_attributes user_condition_params
      add_message_flash :success, t(:updated)
    else
      add_message_flash :danger, t(:updated_fail)
    end
    redirect_to current_user
  end

  private
  def user_condition_params
    params.require(:user).permit :id, user_conditions_attributes: [:id, :condition_detail_id, :is_match, :_destroy]
  end
end
