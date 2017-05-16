class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy, :edit]
  before_action :load_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post::Tip.name_like(params[:name]).of_categor(params[:category_id]).page(params[:page]).per Settings.per_page.tip
    @categories = Category.base_category.instance_children
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user).page(params[:page]).per Settings.per_page.comments
  end

  def create
    @post = Post::UserPost::Tip.new post_params
    if @post.save
      add_message_flash :success, t(:created)
    else
      add_message_flash_now :error, @post.errors.full_messages
    end
    redirect_to current_user
  end

  def edit
  end

  def update
    if @post.update_attributes post_params
      add_message_flash :success, t(:updated)
    else
      add_message_flash :error, @post.errors.full_messages
    end
    redirect_to current_user
  end

  def destroy
    if @post.destroy
      add_message_flash :success, t(:deleted)
    else
      add_message_flash_now :error, @post.errors.full_messages
    end
    redirect_to current_user
  end

  private

  def load_post
    @post = Post.find params[:id]
  end

  def post_params
    params.require(:post).permit(:title, :content ,post_hashtags_attributes: [:id, :hashtag_id, :_destroy], hashtags_attributes: [:name])
      .merge(target_id: current_user.id)
  end
end
