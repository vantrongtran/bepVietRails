class Admin::AdminController < ApplicationController
  layout "admin"
  http_basic_authenticate_with name: "admin", password: "12312311"
end
