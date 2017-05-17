class UsersController < ApplicationController
  layout "user"
  before_action :load_user
  before_action :load_relationship

  def show
    @post = Post.new
    @favorite_foods = @user.favorite_foods.page(params[:page_food]).per 8
    @activities = @user.activities.page(params[:page]).per 10
  end

  def update
    if params[:user][:name].present?
      status =  @user.update_attributes update_user_params
    else
      status =  @user.update_attributes update_avatar_params
    end
    if status
      add_message_flash :success, t(:updated)
    else
      add_message_flash :error, @user.errors.full_messages
    end
    redirect_to user_path(current_user, tab: "profile")
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

  def update_avatar_params
    params.require(:user).permit :avatar
  end

  def update_user_params
    params.require(:user).permit :name, :email, :gender, :birthday
  end
end
