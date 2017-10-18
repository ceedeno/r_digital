class Journal < ApplicationRecord
  belongs_to :user
  has_many :articles, -> {order(position: :asc)}

  after_update :combine_pdfs

  enum status: [:basic, :published]


  def combined_pdfs_name
    id.to_s +  '_combined.pdf'
  end

  def combine_pdfs


     #root_name = id.to_s +  '_combined.pdf'

    file_root = Rails.root.join('public') + combined_pdfs_name.to_s

    #puts '+++++++++++++++++'
    #puts file_root
    #puts '+++++++++++++++++'


    File.delete(file_root) if File.exist?(file_root)


    pdf = CombinePDF.new

    articles.each do |a|
      #puts a.title
      pdf << CombinePDF.load(Rails.root.join('public').to_s + a.file.remote_url)
    end

    #root_name = id.to_s +  '_combined.pdf'

    #update_attribute(:file_name, root_name)

    pdf.save(Rails.root.join('public').to_s + '/' + combined_pdfs_name)

  end


end
