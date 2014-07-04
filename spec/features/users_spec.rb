require 'rails_helper'

feature 'Home page', :js => true do

	scenario 'not logged in' do
		quote = create(:quote)
		visit root_path
		expect(page).to have_content('Sign Up')
		expect(page).to have_content('Log In')
		expect(page).to have_content(quote.content)
		expect(page).to have_content(quote.author)
		expect(page).to have_content(quote.title)
	end
end