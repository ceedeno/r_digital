class Company < ApplicationRecord


  validates :name, :issn, :electronic_issn, :legal_deposit, presence: :true



end
