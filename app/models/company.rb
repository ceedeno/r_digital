class Company < ApplicationRecord


  validates :name, :issn, :address, :electronic_issn, :legal_deposit, presence: :true



end
