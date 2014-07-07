require 'rails_helper'

feature 'Search Quotes', :js => true do

	scenario 'search by title' do
		quote = create(:quote)
		quote_2 = create(:quote)
		visit home_path
		fill_in "q_book_title_cont", with: quote.book.title
		find('.search').click
		expect(page).to have_content(quote.book.title)
		expect(page).to_not have_content(quote_2.book.title)
	end

	scenario 'search by author' do
		quote = create(:quote)
		quote_2 = create(:quote)
		visit home_path
		fill_in "q_author_name_cont", with: quote.author.name
		find('.search').click
		expect(page).to have_content(quote.author.name)
		expect(page).to_not have_content(quote_2.author.name)
	end

	scenario 'search by username' do
		quote = create(:quote)
		quote_2 = create(:quote)
		visit home_path
		fill_in "q_user_goodreads_name_cont", with: quote.user.goodreads_name
		find('.search').click
		expect(page).to have_content(quote.user.goodreads_name)
		expect(page).to_not have_content(quote_2.user.goodreads_name)
	end

end

feature 'Quote Show Page', :js => true do
	scenario 'from the home page' do
		@quote = create(:quote)
		visit home_path
		expect(page).to have_button("See more")
		click_button "See more"
		expect(current_path).to eq "/quotes/#{@quote.id}"
		expect(page).to have_content("This is a quote show page")
	end
end

feature "Favoriting Quotes", :js => true do
	let!(:user) { create(:user) }
	
	scenario 'when a quote is not favorited' do
		allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
		allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(true)
		user_quote = create(:quote)
    	user.quotes << user_quote
		visit home_path
		expect(page).to have_selector(".unliked-quote")
		find(".unliked-quote").click
		expect(page).to have_selector(".liked-quote")
		expect(page).to_not have_selector(".unliked-quote")
	end

	scenario 'when a quote is already favorited' do
		allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
		allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(true)
		user_quote = create(:quote)
		user.quotes << user_quote
    	user.favorites << user_quote
		visit home_path
		expect(page).to have_selector(".liked-quote")
		find(".liked-quote").click
		expect(page).to have_selector(".unliked-quote")
		expect(page).to_not have_selector(".liked-quote")
	end

	scenario "when not logged in, no option to favorite or unfavorite" do
		allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(false)
		quote = create(:quote)
		visit home_path
		expect(page).to_not have_selector(".liked-quote")
		expect(page).to_not have_selector(".unliked-quote")
	end
end