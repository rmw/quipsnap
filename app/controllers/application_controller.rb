class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :oauth_consumer, :goodreads_client, :get_quotes

  def current_user
    @user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !(current_user.nil?)
  end

  def oauth_consumer
    @consumer ||= OAuth::Consumer.new(ENV['GR_KEY'], ENV['GR_SECRET'], :site => 'http://www.goodreads.com')
  end

  # need to fill this in. represents a logged in user, so we can make API calls on their behalf
  def goodreads_client
    @client ||= Goodreads::Client.new(:api_key => ENV['GR_KEY'], :api_secret => ENV['GR_SECRET'])
  end

  def get_quotes(user)
    updates = goodreads_client.user(user.goodreads_user_id).updates
    filtered_quotes = updates.select{|quote| quote.action_text == "liked a quote"}
    filtered_quotes.each do |quote|
      final_quote = Quote.create(content: quote.body, goodreads_link: quote.link, author: "test_author", title: "test_title")
      user.quotes << final_quote
    end
  end
end