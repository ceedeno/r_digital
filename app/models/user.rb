class User < ApplicationRecord

  include Rails.application.routes.url_helpers

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :articles

  enum role: [:basic, :adviser, :referee, :tmdcm, :ecm, :director]


end
