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

  private

  def bookclub_params
    params.require(:bookclub).permit(:name, :description)
  end
end
