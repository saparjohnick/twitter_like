class UserNotifyMailer < ApplicationMailer
  def notify_email
    @user = params[:user]
    mail(to: @user.email, subject: "Hey! Don't forget about Twitterlike app! Have a nice day!")
  end
end
