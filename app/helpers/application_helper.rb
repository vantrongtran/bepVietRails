module ApplicationHelper
  def add_food food
    render "admin/foods/modal_add", food: food
  end

  def j_render_flash
    arrays = []
    flash.each do |message_type, messages|
      messages.each do |message|
         arrays.push("#{j render("layouts/flash", type: message_type, message: message)}".to_s)
      end
    end
    arrays
  end
end
