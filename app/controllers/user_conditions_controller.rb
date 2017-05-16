class UserConditionsController < ApplicationController
  before_action :authenticate_user!

  def create
    if current_user.update_attributes user_condition_params
      add_message_flash :success, t(:updated)
    else
      add_message_flash :danger, current_user.errors.full_messages
    end
    redirect_to current_user
  end

  private
  def user_condition_params
    params.require(:user).permit :id, user_conditions_attributes: [:id, :condition_detail_id, :is_match, :_destroy]
  end
end
