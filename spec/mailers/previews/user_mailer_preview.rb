# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def article_email
    UserMailer.article_email(User.first, Article.find(1))
  end


  def referee_expire_notification
    UserMailer.referee_expire_notification(User.first, Article.first)

  end

end
