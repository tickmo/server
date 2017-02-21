class UserMail < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome! Tickmo team is Greating You')
  end
end
