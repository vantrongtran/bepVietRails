class FollowingController < UsersController
  layout "user"

  def index
    @users = @user.following.name_like(params[:keyword]).page(params[:page])
  end

  private
  def load_user
    @user = User.find params[:user_id]
  end
end
