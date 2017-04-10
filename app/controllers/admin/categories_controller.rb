class Admin::CategoriesController < Admin::AdminController
  before_action :load_category, only: [:update, :destroy]

  def index
    @categories = Category.all
    @ends = []
  end

  def update
    if @category.update_attributes name: params[:name]
       add_message_flash :success, t(:updated)
    else
      add_message_flash :warning, @category.errors.full_messages
    end
    redirect_to admin_categories_path
  end

  def destroy
    if @deleted = @category.destroy
      add_message_flash :warning, t(:deleted)
    else
      add_message_flash :danger, t(:deleted_fail)
    end
    redirect_to admin_categories_path
  end

  private
  def load_category
    @category = Category.find params[:id]
  end
end
