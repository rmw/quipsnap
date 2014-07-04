class UsersController < ApplicationController
	def index
		@quotes = Quote.all
	end
end
