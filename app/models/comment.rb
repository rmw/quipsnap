class Comment < ActiveRecord::Base
	validates :content, presence: true
	validates :user, presence: true
	belongs_to :user
	belongs_to :quote

	# direct replies to a comment 
	def direct_replies
		Comment.where(parent_id: self.id)
	end

	# recursively call direct_replies until empty to get the entire comment chain for a single quote
	def all_replies
	end

	# the comment that the given comment is in response to. nil, if the "parent comment" is acutally the quote 
	def parent_comment
		# this needs to be find_by rather than find, so it returns nil rather than throwing an error if comment not found
		Comment.find_by(id: self.parent_id)
	end
end
