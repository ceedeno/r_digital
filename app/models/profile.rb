class Profile < ApplicationRecord

  belongs_to :user


  validates :last_name, :address, :institution, :bio, :phone, :country, presence: :true

end
