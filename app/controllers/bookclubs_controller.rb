class BookclubsController < ApplicationController
  def index
    redirect_to home_path if !logged_in?
    @bookclub = Bookclub.new
  end

  def all
    @bookclubs = Bookclub.all
    render json: { bookclubs: @bookclubs }.to_json
  end

  def create
    @bookclub = Bookclub.new(bookclub_params)
    @bookclub.admin = current_user
    if @bookclub.save
      @bookclub.users << current_user
      render json: { bookclub: @bookclub }.to_json
    else
      render status: :unprocessable_entity, json: { message: "Can't add bookclub!" }.to_json
    end
  end

  def add_quote
    Bookclub.find(params[:bookclub_id]).quotes << Quote.find(params[:quote_id])
    render json: {isSuccess: true}
  end

  def join
    bookclub = Bookclub.find(params[:bookclub_id])
    bookclub.users << current_user
    render json: { bookclub_id: bookclub.id }.to_json
  end

  private

  def bookclub_params
    params.require(:bookclub).permit(:name, :description)
  end

end
