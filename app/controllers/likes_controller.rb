class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = Like.find_or_initialize_by like_params.merge(user_id: current_user.id)
    if @result = @like.save
      add_message_flash_now :success, t(:liked)
    else
      add_message_flash_now :danger, t(:liked_faild)
    end
  end

  def destroy
    @like = Like.find(params[:id])
    if @result = @like.destroy
      add_message_flash_now :info, t(:unliked)
    else
      add_message_flash_now :danger, t(:liked_faild)
    end
  end

  private
  def like_params
    params.require(:like).permit :target_id, :target_type
  end
end
