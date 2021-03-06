class User < ApplicationRecord

  REFEREE_MAX_DAYS = 2.days

  include Rails.application.routes.url_helpers

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  delegate :last_name, :gender, :institution, :phone, :address, :country, :bio, :web_site, :speciality, to: :profile


  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  has_many :articles, dependent: :destroy
  has_many :journals, dependent: :destroy
  has_many :reviewed_users_articles, class_name: 'UsersArticle', dependent: :destroy
  has_many :reviewed_articles, through: :reviewed_users_articles, source: :article

  # tmdcm: technical management draftinf comitee member,  ecm: editorial comitee member
  enum role: [:basic, :adviser, :referee, :tmdcm, :ecm, :director, :admin]
  enum gender: [:masculino, :femenino]


  after_update :check_something
  before_create {build_profile}


  #validates :first_name, :last_name, :address, :institution, :bio, :phone, :country, presence: :true
  validates :first_name, presence: :true



  def first_name_and_speciality
    String(first_name) + ' ' + String(last_name) + ' (' + String(speciality) + ' )'
  end

  def reviewed_article?(article)
    reviewed_articles.include?(article)
  end

  def check_something

    articles = Article.where(status: :eca).where('referee_assigned_date < ?', Date.today - REFEREE_MAX_DAYS )

    articles.each do |a|
      unless a.referee_reviewed_users.include?(a&.selected_referee.referee_1)
        UserMailer.referee_expire_notification(a&.selected_referee.referee_1, a).deliver_later
        a&.selected_referee.referee_1 = nil
      end
      unless a.referee_reviewed_users.include?(a&.selected_referee.referee_2)
        UserMailer.referee_expire_notification(a&.selected_referee.referee_2, a).deliver_later
        a&.selected_referee.referee_2 = nil
      end
      unless a.referee_reviewed_users.include?(a&.selected_referee.referee_3)
        UserMailer.referee_expire_notification(a&.selected_referee.referee_3, a).deliver_later
        a&.selected_referee.referee_3 = nil
      end

      a.save
    end

  end


end
