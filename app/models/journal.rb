class Journal < ApplicationRecord
  belongs_to :user
  has_many :articles, -> {order(position: :asc)}

  after_update :combine_pdfs


  def combine_pdfs

    file_root = Rails.root.join('public') + file_name.to_s
    File.delete(file_root) if File.exist?(file_root)


    pdf = CombinePDF.new

    articles.each do |a|
      #puts a.title
      pdf << CombinePDF.load(Rails.root.join('public').to_s + a.file.remote_url)
    end

    #TODO remove any file if exist

    root_name = id.to_s +  '_combined.pdf'

    update_attribute(:file_name, root_name)

    pdf.save(Rails.root.join('public').to_s + '/' + root_name)

  end


end
