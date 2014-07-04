class QuotesController < ApplicationController
	def search
		@search = Quote.search(params[:q])
	    @quotes = @search.result.includes(:user)
	    render "users/index"
	end
end
