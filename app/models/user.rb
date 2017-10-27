class User < ApplicationRecord

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


  def reviewed_article?(article)
    reviewed_articles.include?(article)
  end


end
