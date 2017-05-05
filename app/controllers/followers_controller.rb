class FollowersController < UsersController
  layout "user"
  before_action :load_user

  def index
    @users = @user.followers.name_like(params[:keyword]).page(params[:page])
  end

  protected
  def load_user
    @user = User.find params[:user_id]
  end
end
