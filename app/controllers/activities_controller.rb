class ActivitiesController < ApplicationController

  def destroy
    @activity = Activity.find params[:id]
    if @activity.destroy
      add_message_flash :success, t(:deleted)
    else
      add_message_flash_now :error, @activity.errors.full_messages
    end
    redirect_to user_path(current_user, tab: "activities")
  end
end
