class BookclubsController < ApplicationController

  # GET /bookclubs
  def index
    redirect_to home_path if !logged_in?
    @search = Quote.search(params[:q])
    @bookclub = Bookclub.new
  end

  # POST /bookclubs
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

  # GET /bookclubs/all
  def all
    @bookclubs = Bookclub.all
    render json: { bookclubs: @bookclubs }.to_json
  end

  # POST /bookclubs/:bookclub_id/quotes/:quote_id
  def add_quote
    @quote = Quote.find(params[:quote_id])
    @bookclub = Bookclub.find(params[:bookclub_id])
    if @bookclub.quotes.include?(@quote)
      quote_added = false
    else
      quote_added = true
      @bookclub.quotes << @quote
    end
    render json: {quote_added: quote_added}
  end

  # GET /bookclubs/:bookclub_id
  def show
    @quotes = Bookclub.find(params[:bookclub_id]).quotes
    if logged_in?
      @favorites = @quotes.map do |quote| 
        QuoteFavorite.find_by(quote_id: quote.id, user_id: current_user.id) ? true : false
      end
    end

    render json: {quotes: @quotes, is_favorites: @favorites } 
  end

  # PUT /bookclubs/join
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
