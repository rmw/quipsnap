class QuotesController < ApplicationController

  # GET /quotes/:id
	def show
		@quote = Quote.find_by(id: params[:id])
	end

  # POST /
	def search
		@search = logged_in? ? Quote.where(user_id: current_user.id).search(params[:q]) : Quote.search(params[:q])
    @quotes = @search.result.includes(:user).order("created_at DESC")
    render "users/index"
	end
end
