class Admin::UsersController < Admin::AdminController
  def index
    @users = User.name_like(params[:keyword]).page(params[:page]).per(10)
  end

  def destroy
    @user = User.find params[:id]
    if @user.destroy
      add_message_flash :success, t(:deleted)
    else
      add_message_flash_now :error, @user.errors.full_messages
    end
    redirect_to admin_users_path
  end
end
