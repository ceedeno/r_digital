class Article < ApplicationRecord
  belongs_to :user
  belongs_to :journal


  has_many :users_articles, class_name: 'UsersArticle'
  has_many :reviewed_users, through: :users_articles, source: :user
  has_many :referee_reviewed_users, -> {where role: :referee}, through: :users_articles, source: :user
  has_many :ecm_reviewed_users, -> {where role: :ecm}, through: :users_articles, source: :user

  dragonfly_accessor :file

  # editorial comitee approved, to correct by editorial comitee, to correct by referres
  enum status: [:basic, :rejected, :eca, :tcbec, :pending_review, :approved_by_referees, :tcbr, :approved, :published]

end
