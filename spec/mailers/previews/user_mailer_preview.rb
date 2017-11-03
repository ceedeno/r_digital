# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def article_email
    UserMailer.article_email(User.first, Article.first)
  end

end
