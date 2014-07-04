class Quote < ActiveRecord::Base
	validates :content, presence: true
	validates :author, presence: true
	validates :title, presence: true
	belongs_to :user

	# Only allow users to use Ransack to search quotes by title and author
	def self.ransackable_attributes(auth_obj = nil)
		["title", "author"]
	end
	
	# Only allow users to use Ransack to search quotes by user
	def self.ransackable_associations(auth_obj = nil)
		["user"]
	end
end