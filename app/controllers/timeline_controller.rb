class TimelineController < ApplicationController
  layout "user"
  def index
    @user = current_user
    @posts = Post::UserPost.where(target_id: current_user.following.map(&:id)).includes(:user).page(params[:page]).per 8
  end
end
