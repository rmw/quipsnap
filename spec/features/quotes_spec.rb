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