module ApplicationHelper
  def add_food food
    render "admin/foods/modal_add", food: food
  end
end
