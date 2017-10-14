class UsersArticle < ApplicationRecord
  belongs_to :user
  belongs_to :article


  enum status: [:basic, :other]
end
