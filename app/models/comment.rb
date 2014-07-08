class Comment < ActiveRecord::Base
	validates :content, presence: true
	validates :user, presence: true
	belongs_to :user
	belongs_to :quote

	# recursively call to get the entire reply chain for a single comment
	def all_replies
		chain = { comment_id: self.id, parent_id: self.parent_id, quote_id: self.quote_id, comment_content: self.content, user: self.user.goodreads_name, replies: []}
		self.direct_replies.each do |reply|
			chain[:replies] << reply.all_replies 
		end
		return chain
	end
	
	# direct replies to a comment 
	def direct_replies
		Comment.where(parent_id: self.id)
	end

	# the comment that the given comment is in response to. nil, if the "parent comment" is acutally the quote 
	def parent_comment
		# this needs to be find_by rather than find, so it returns nil rather than throwing an error if comment not found
		Comment.find_by(id: self.parent_id)
	end

end
