json.extract! journal, :id, :identifier, :editor, :publisher, :indexing, :copyright, :subject, :others, :user, :created_at, :updated_at
json.url journal_url(journal, format: :json)
