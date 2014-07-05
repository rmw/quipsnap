class Quote < ActiveRecord::Base
	validates :content, presence: true
	validates :goodreads_link, presence: true, uniqueness: true
	belongs_to :user
	belongs_to :author
	belongs_to :book

	has_many	:bookclub_quotes
	has_many	:bookclubs, through: :bookclub_quotes

	# Only allow users to use Ransack to search quotes by title and author
	def self.ransackable_attributes(auth_obj = nil)
		[]
	end
	
	# Only allow users to use Ransack to search quotes by user
	def self.ransackable_associations(auth_obj = nil)
		["user", "author", "book"]
	end
end