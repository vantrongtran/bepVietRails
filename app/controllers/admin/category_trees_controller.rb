class Admin::CategoryTreesController < Admin::AdminController
  def index
    @json = to_node_structure Category.unscoped.first
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
end
