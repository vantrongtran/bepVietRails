class UsersController < ApplicationController
  layout "user"
  before_action :load_user
  before_action :load_relationship

  def show
  end

  protected
  def load_relationship
    load_user
    if user_signed_in?
      @relationship = current_user.active_relationships
        .find_or_initialize_by followed_id: @user.id
    end
  end

  def load_user
    @user = User.includes(:user_conditions, :activities).find(params[:id])
    @user.user_conditions.includes(:condition_detail, condition: :condition_details)
  end
end
