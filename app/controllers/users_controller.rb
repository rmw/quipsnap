class UsersController < ApplicationController

  # ROOT
  def index
  	@search = logged_in? ? Quote.where(user_id: current_user.id).search(params[:q]) : Quote.search(params[:q])
  	@quotes = @search.result.includes(:user).order("created_at DESC")
  	@bookclubs = logged_in? ? current_user.bookclubs : nil
  end
  
end
