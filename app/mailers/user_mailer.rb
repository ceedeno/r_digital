class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def article_email(user, article)
    @user = user
    @article = article
    mail(to: @user.email, subject: 'Notificación de artículo')
  end

  def referee_expire_notification(user, article)
    @user = user
    @article = article
    mail(to: @user.email, subject: 'Notificación de artículo')
  end


end
