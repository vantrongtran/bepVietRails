module ApplicationHelper
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
