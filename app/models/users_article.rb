class UsersArticle < ApplicationRecord
  belongs_to :user
  belongs_to :article

  # uniqueness of (user_id, article_id) as primary_key
  validates :user_id, uniqueness: { scope: :article_id }

  # editorial comitee approved, to correct by editorial comitee, to correct by referres, rejected by editorial comitee
  enum status: [:basic, :rejected_by_ec, :rejected_by_r, :eca, :tcbec, :approved_by_referee, :tcbr]
end
