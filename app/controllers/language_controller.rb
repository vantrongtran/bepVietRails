class LanguageController < ApplicationController
  def index
    session[:locale] = params[:locale] if params[:locale].present?
    I18n.locale = session[:locale] || I18n.default_locale
    add_message_flash :success, t(:language_update)
    session[:forwarding_url] = root_path if session[:forwarding_url] == request.original_url
    redirect_to session[:forwarding_url] || root_path
  end
end
