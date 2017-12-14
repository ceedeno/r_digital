class Journal < ApplicationRecord
  belongs_to :user
  belongs_to :volume
  has_many :articles, -> {order(position: :asc)}

  after_update :combine_pdfs
  after_create :combine_pdfs

  after_update :check_published


  enum status: [:basic, :published]

  dragonfly_accessor :cover


  validates :identifier, :editor, :cover, :max_articles, presence: :true



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

    if cover
      pdf << CombinePDF.load(Rails.root.join('public').to_s + cover.remote_url)
    end

    articles.each do |a|
      #puts a.title
      pdf << CombinePDF.load(Rails.root.join('public').to_s + a.file.remote_url)
    end

    #root_name = id.to_s +  '_combined.pdf'

    #update_attribute(:file_name, root_name)

    pdf.save(Rails.root.join('public').to_s + '/' + combined_pdfs_name)

  end



  def check_published
    if published?
      articles.each do |a|
        a.update_attribute(:status, :published)
      end
    else
      articles.each do |a|
        a.update_attribute(:status, :assigned_journal)
      end

    end

  end


end
