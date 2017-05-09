class Admin::PostsController < Admin::AdminController
  before_action :load_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.page(params[:page]).per(10)
    @post = Post.new
  end

  def new
  end

  def create
    @post = Post.new post_params
    if @post.save
      add_message_flash :success, t(:created)
    else
      add_message_flash_now :error, t(:failed)
    end
    redirect_to admin_posts_path
  end

  def edit
  end

  def update
    if @post.update_attributes post_params
      add_message_flash :success, t(:updated)
    else
      add_message_flash :error, t(:failed)
    end
    redirect_to admin_posts_path
  end

  def destroy
    if @post.destroy
      add_message_flash :success, t(:deleted)
    else
      add_message_flash_now :error, t(:failed)
    end
    redirect_to admin_posts_paths
  end

  private
  def load_post
    @post = Post.find params[:id]
  end

  def post_params
    params.require(:post).permit :title, :content, :image, :category_id
  end
end
