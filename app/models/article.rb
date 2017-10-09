class Article < ApplicationRecord
	belongs_to :user
	belongs_to :journal

	dragonfly_accessor :file
end
