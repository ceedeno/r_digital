class User < ApplicationRecord

  include Rails.application.routes.url_helpers

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :articles

  enum role: [:basic, :adviser, :referee, :tmdcm, :ecm, :director]


  def combine_pdfs
    pdf = CombinePDF.new

    articles.each do |a|
      pdf << CombinePDF.load(Rails.root.join('public').to_s + a.file.remote_url)
    end

    #TODO remove any file if exist

    root_name = Time.now.to_i.to_s + '_combined.pdf'
    update_attribute(:name, root_name)
    pdf.save(Rails.root.join('public').to_s + '/' + root_name)
  end



end
