class Volume < ApplicationRecord

  has_many :journals, dependent: :destroy

end
