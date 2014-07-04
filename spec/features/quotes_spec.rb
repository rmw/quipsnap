require 'rails_helper'

feature 'Search Quotes', :js => true do

	scenario 'search by title' do
		quote = create(:quote)
		quote_2 = create(:quote)
		visit home_path
		fill_in "q_title_cont", with: quote.title
		click_button "Search"
		expect(page).to have_content(quote.title)
		expect(page).to_not have_content(quote_2.title)
	end

	scenario 'search by author' do
		quote = create(:quote)
		quote_2 = create(:quote)
		visit home_path
		fill_in "q_author_cont", with: quote.author
		click_button "Search"
		expect(page).to have_content(quote.author)
		expect(page).to_not have_content(quote_2.author)
	end

	scenario 'search by username' do
		quote = create(:quote)
		quote_2 = create(:quote)
		visit home_path
		fill_in "q_user_username_cont", with: quote.user.username
		click_button "Search"
		expect(page).to have_content(quote.user.username)
		expect(page).to_not have_content(quote_2.user.username)
	end

end