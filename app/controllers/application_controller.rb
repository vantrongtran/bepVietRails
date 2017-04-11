class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def add_message_flash type, message
    flash[type] ||= []
    flash[type].push *message
  end

  def add_message_flash_now type, message
    flash.now[type] ||= []
    flash.now[type].push *message
  end
end
