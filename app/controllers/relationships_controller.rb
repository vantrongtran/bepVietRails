class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find params[:followed_id]
    current_user.follow @user unless @user == current_user
    @relationship = current_user.active_relationships.find_by followed_id: @user.id
    respond
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow @user
    @relationship = current_user.active_relationships.build
    respond
  end

  private
  def user_not_found
    flash[:danger] = t :user_not_found
    redirect_to users_path and return
  end

  def respond
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end
