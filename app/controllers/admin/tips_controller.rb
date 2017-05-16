class Admin::TipsController < Admin::AdminController
  before_action :load_tip, only: [:edit, :update, :destroy]

  def index
    @posts = Post::Tip.all.page(params[:page]).per(10)
    @tip = Post::Tip.new
  end

  def new
  end

  def create
    @post = Post::Tip.new post_params
    if @post.save
      add_message_flash :success, t(:created)
    else
      add_message_flash_now :error, t(:failed)
    end
    redirect_to admin_tips_path
  end

  def edit
  end

  def update
    if @post.update_attributes post_params
      add_message_flash :success, t(:updated)
    else
      add_message_flash :error, t(:failed)
    end
    redirect_to admin_tips_path
  end

  def destroy
    if @post.destroy
      add_message_flash :success, t(:deleted)
    else
      add_message_flash_now :error, t(:failed)
    end
    redirect_to admin_tips_path
  end

  private
  def load_tip
    @post = Post::Tip.find params[:id]
  end

  def post_params
    params.require(:post).permit :title, :content, :image, :target_id, post_hashtags_attributes: [:id, :hashtag_id, :_destroy], hashtags_attributes: [:name]
  end
end
