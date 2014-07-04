module ApplicationHelper
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
