class Admin::AdminController < ApplicationController
  layout "admin"
  before_action :set_locale
  http_basic_authenticate_with name: "admin", password: "12312311"

  def set_locale
    I18n.locale = :en
  end
end
