class UserNotifierMailer < ApplicationMailer
  def send_email_notifier_comment user, post
    @user = user
    @post = post
    mail to: user.email, subject: t("mailer.comment.subject", name: user.name)
  end
end
