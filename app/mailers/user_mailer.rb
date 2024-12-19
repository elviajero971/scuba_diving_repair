class UserMailer < ApplicationMailer
  default from: 'scubadiving.nomadev.online'

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to Scubadiving App')
  end
end
