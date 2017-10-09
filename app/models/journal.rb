class Journal < ApplicationRecord
  belongs_to :user
  has_many :articles

end
