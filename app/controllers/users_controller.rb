class UsersController < ApplicationController
	def index
    @search = Quote.search(params[:q])
    @quotes = @search.result.includes(:user)
	end
end
