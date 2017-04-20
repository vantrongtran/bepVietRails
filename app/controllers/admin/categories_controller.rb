class Admin::CategoriesController < Admin::AdminController
  before_action :load_category, only: [:update, :destroy]

  def index
    @categories = Category.all.page(params[:page])
    @ends = []
    @json = to_node_structure Category.unscoped.first
  end

  def create
    parent = Category.unscoped.find params[:parent_id]
    respont = Category.add params[:name], parent.right, parent.level
    add_message_flash respont[:type], respont[:messages]
    redirect_to admin_categories_path
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
  def to_node_structure category
    children = category.instance_children
    if children.any?
      {
        text: {name: category.name, title: "Left: #{category.left}  |  Right: #{category.right}"},
        children: children.map {|child| to_node_structure child}
      }
    else
      {
        text: {name: category.name, title: "Left: #{category.left}  |  Right: #{category.right}"}
      }
    end
  end


  def load_category
    @category = Category.find params[:id]
  end
end
