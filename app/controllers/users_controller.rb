class UsersController < ApplicationController
  before_action :load_user, only: :show

  def show
    if user_signed_in?
      @relationship = current_user.active_relationships
        .find_or_initialize_by followed_id: @user.id
    end
    @users = User.all.page params[:page]
  end

  private
  def load_user
    @user = User.find params[:id]
  end
end
