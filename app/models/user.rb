class User < ApplicationRecord

  REFEREE_MAX_DAYS = 1.days

  include Rails.application.routes.url_helpers

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :articles, dependent: :destroy
  has_many :journals, dependent: :destroy
  has_many :reviewed_users_articles, class_name: 'UsersArticle', dependent: :destroy
  has_many :reviewed_articles, through: :reviewed_users_articles, source: :article

  # tmdcm: technical management draftinf comitee member,  ecm: editorial comitee member
  enum role: [:basic, :adviser, :referee, :tmdcm, :ecm, :director, :admin]
  enum gender: [:masculino, :femenino]


  after_update :check_something


  def first_name_and_speciality
    String(first_name) + ' ' + String(last_name) + ' (' + String(speciality) + ' )'
  end

  def reviewed_article?(article)
    reviewed_articles.include?(article)
  end

  def check_something

    articles = Article.where(status: :eca).where('referee_assigned_date < ?', Date.today - REFEREE_MAX_DAYS )

    articles.each do |a|
      unless a.referee_reviewed_users.include?(a.referee_1)
        UserMailer.referee_expire_notification(a.referee_1, a).deliver_later
        a.referee_1 = nil
      end
      unless a.referee_reviewed_users.include?(a.referee_2)
        UserMailer.referee_expire_notification(a.referee_2, a).deliver_later
        a.referee_2 = nil
      end
      unless a.referee_reviewed_users.include?(a.referee_3)
        UserMailer.referee_expire_notification(a.referee_3, a).deliver_later
        a.referee_3 = nil
      end

      a.save
    end

  end


end
