class QuotesController < ApplicationController

  # GET /quotes/:id
  def show
  	@quote = Quote.find_by(id: params[:id])
  	render "show", locals: {quote: @quote} 
  end

  # POST /
  def search
  	@search = Quote.search(params[:q])
  	@quotes = @search.result.includes(:user).order("created_at DESC")
  	@bookclubs = logged_in? ? current_user.bookclubs : nil
  	render "users/index"
  end
end
