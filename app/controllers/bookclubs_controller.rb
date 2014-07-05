class BookclubsController < ApplicationController
  def index
    redirect_to home_path if !logged_in?
    @bookclubs = Bookclub.all
    @bookclub = Bookclub.new
  end

  def create
    @bookclub = Bookclub.new(bookclub_params)
    if @bookclub.save
      @error = false
    else
      @error = true
    end
    redirect_to "bookclubs/index"
  end

  def add_quote
    Bookclub.find(params[:bookclub_id]).quotes << Quote.find(params[:quote_id])
    render json: {isSuccess: true}
  end

  private

  def bookclub_params
    params.require(:bookclub).permit(:name, :description)
  end

end
