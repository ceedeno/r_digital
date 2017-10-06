class Article < ApplicationRecord
	belongs_to :user 

	dragonfly_accessor :file
end
