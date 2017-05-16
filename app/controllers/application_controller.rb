class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale
  after_action :add_instance_page, only: [:index, :show]

  def add_message_flash type, message
    flash[type] ||= []
    flash[type].push *message
  end

  def add_message_flash_now type, message
    flash.now[type] ||= []
    flash.now[type].push *message
  end

  private
  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def add_instance_page
    session[:forwarding_url] = request.original_url if request.get? && request.format.html?
  end
end
