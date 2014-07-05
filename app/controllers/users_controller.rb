class UsersController < ApplicationController
	def index
		@search = logged_in? ? Quote.where(user_id: current_user.id).search(params[:q]) : Quote.search(params[:q])
    	@quotes = @search.result.includes(:user).order("created_at DESC")
	end
end
