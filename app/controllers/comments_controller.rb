class CommentsController < ApplicationController
	def create
		# if user comments on a quote, params[:comment_id] will be nil (i.e. it is a root comment for a quote comment tree)
		# if user comments on another comment, params[:comment_id] will be the id of that comment
		@comment = Comment.new(
			content: params[:comment], 
			user_id: current_user.id, 
			parent_id: params[:comment_id].to_i,
			quote_id: params[:quote_id].to_i
			)
		# @success_or_fail_message = @comment.save ? "Comment Saved Successfully" : "Unable to Save Comment"
		@isSuccess = @comment.save ? true : false
		render json: { isSuccess: @isSuccess, 
			comment_content: @comment.content, 
			comment_id: @comment.id, 
			user: @comment.user.goodreads_name,
			parent_id: params[:comment_id],
			quote_id: params[:quote_id] 
		}
	end

end
