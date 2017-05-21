class Admin::DashboardController < Admin::AdminController
  def index
  end

  def create
    UserNotifierMailer.sent_email_notifier(params[:subject], params[:content]).deliver_now
  end
end
