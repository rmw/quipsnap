class QuotesController < ApplicationController

  # GET /quotes/:id
  def show
  	@search = Quote.search(params[:q])
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
  
  # POST /quotes/:id/favorite
  def favorite
    @quote_fav = QuoteFavorite.new(user_id: current_user.id, quote_id: params[:id])
    @is_success = @quote_fav.save ? true : false
    render json: {isSuccess: @is_success}
  end

  # DELETE /quotes/:id/unfavorite
  def unfavorite
    @quote_fav = QuoteFavorite.find_by(user_id: current_user.id, quote_id: params[:id])
    @is_success = @quote_fav.destroy ? true : false
    render json: {isSuccess: @is_success}
  end
end
