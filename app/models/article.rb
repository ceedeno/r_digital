class Article < ApplicationRecord
  belongs_to :user
  belongs_to :journal

  #belongs_to :referee_1, class_name: 'User'
  #belongs_to :referee_2, class_name: 'User'
  #belongs_to :referee_3, class_name: 'User'

  belongs_to :tmdcm_1, class_name: 'User'
  belongs_to :tmdcm_2, class_name: 'User'


  has_many :users_articles, class_name: 'UsersArticle'
  has_many :reviewed_users, through: :users_articles, source: :user
  has_many :referee_reviewed_users, -> {where role: :referee}, through: :users_articles, source: :user
  has_many :ecm_reviewed_users, -> {where role: :ecm}, through: :users_articles, source: :user

  has_one :selected_referee, dependent: :destroy
  accepts_nested_attributes_for :selected_referee

  default_scope {order('status DESC')}

  dragonfly_accessor :file

  before_create :build_referee

  after_save :send_email
  #after_update :set_referee_assigned_date


  after_update :check_corrected

  # eca: editorial comitee approved, to correct by editorial comitee, to correct by referres
  enum status: [:basic, :rejected, :eca, :tcbec, :pending_review, :approved_by_referees, :tcbr, :approved, :assigned_journal, :published]

  enum kind: [:review, :paper, :brief_communication, :comment]

  validates :title, presence: :true
  validates :abstract, presence: :true
  validates :language, presence: :true
  validates :file, presence: :true


  def title_and_key_words
    String(title) + ' (' + String(key_words) + ' )'
  end

  def update_users_article(user, article_status, note, referee_1_id, referee_2_id, referee_3_id)

    user_article = UsersArticle.new(user: user, article: self, status: article_status, correction_note: note,
                                    referee_1_id: referee_1_id, referee_2_id: referee_2_id, referee_3_id: referee_3_id)

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

      elsif ecm_reviewed_users.count == 3 && ac + dc > rc && ac <= dc
        update_attribute(:status, :tcbec)

      elsif ecm_reviewed_users.count == 3 && ac + dc <= rc
        update_attribute(:status, :rejected)
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
      elsif referee_reviewed_users.count == 3 && ac + dc > rc && ac <= dc
        update_attribute(:status, :tcbr)
      elsif referee_reviewed_users.count == 3 && ac + dc <= rc
        update_attribute(:status, :rejected)
      end

    end


  end


  def suggested_referees
    referees = []
    users_articles.each do |ua|
      referees << ua.referee_1
      referees << ua.referee_2
      referees << ua.referee_3
    end

    referees.uniq.compact

  end

  def selected_referees
    [selected_referee&.referee_1, selected_referee&.referee_2, selected_referee&.referee_3]
  end


  private

  def send_email
    if basic? || approved? || rejected? || tcbec? || published?
      UserMailer.article_email(user, self).deliver_later
    end
  end


  def set_referee_assigned_date
    if saved_change_to_referee_1_id? || saved_change_to_referee_2_id? || saved_change_to_referee_3_id?

      update_attribute(:referee_assigned_date, Date.today)
      #self.referee_assigned_date = Date.today
    end
  end


  def check_corrected
    if tcbec? && checked_as_corrected
      update_attributes(checked_as_corrected: false, status: :basic)
      users_articles.each do |ua|
        if ua.user.role == "ecm"
          ua.destroy
        end
      end
    elsif tcbr? && checked_as_corrected
      update_attributes(checked_as_corrected: false, status: :eca)
      users_articles.each do |ua|
        if ua.user.role == "referee"
          ua.destroy
        end
      end
    end


  end


  def build_referee
    build_selected_referee
  end

end
