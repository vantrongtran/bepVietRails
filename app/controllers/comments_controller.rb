class CommentsController < ApplicationController
  before_action :load_comment, only: :destroy
  def create
    @comment = Comment.create comment_params
    if @comment.save
      add_message_flash :success, t(:created)
    else
      add_message_flash :error, t(:create_fail)
    end
  end

  def destroy
    if @comment.destroy
      add_message_flash :success, t(:deleted)
    else
      add_message_flash :error, @comment.errors.full_messages
    end
  end

  private
  def load_comment
    @comment = Comment.find params[:id]
  end

  def comment_params
    params.require(:comment).permit(:content, :target_id, :target_type).merge user_id: current_user.id
  end
end
