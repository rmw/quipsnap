require 'rails_helper'

feature 'Home page', :js => true do

	scenario 'not logged in' do
		quote = create(:quote)
		visit home_path
		expect(page).to have_content('Sign in with GoodReads')
		expect(page).to have_content(quote.content)
		expect(page).to have_content(quote.author.name)
		expect(page).to have_content(quote.book.title)
	end
end