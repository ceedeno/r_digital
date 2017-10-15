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


  def update_users_article(user, article_status, note)
    user_article = UsersArticle.new(user: user, article: self, status: article_status, correction_note: note)

    users_articles << user_article

    # count editorial comitee

    ac = 0
    rc = 0
    dc = 0

    if basic?
      users_articles.each do |ua|
        ac += 1 if ua.eca?
        rc += 1 if ua.rejected_by_ec?
        dc += 1 if ua.tcbec?
      end

      if ecm_reviewed_users.count == 3 && ac + dc > rc && ac > dc
        update_attribute(:status, :eca)
      end


      # count referees members
    elsif eca?
      users_articles.each do |ua|
        ac += 1 if ua.approved_by_referee?
        rc += 1 if ua.rejected_by_r?
        dc += 1 if ua.tcbr?
      end

      if referee_reviewed_users.count == 3 && ac + dc > rc && ac > dc
        update_attribute(:status, :approved)
      end

    end


  end


  private


end
