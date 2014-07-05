require 'rails_helper'

feature 'Home page', :js => true do

  let(:user) {create(:user)}

  scenario 'logged in' do
    user_quote = create(:quote)
    non_user_quote = create(:quote)
    user.quotes << user_quote
    allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit home_path
    expect(page).to have_content(user_quote.content)
    expect(page).to have_content(user_quote.author.name)
    expect(page).to have_content(user_quote.book.title)
    expect(page).to_not have_content(non_user_quote.content)
    expect(page).to_not have_content(non_user_quote.author.name)
    expect(page).to_not have_content(non_user_quote.book.title)
    expect(page).to have_selector('.nav-bookclubs')
  end

	scenario 'not logged in' do
		quote = create(:quote)
		visit home_path
		expect(page).to have_content('Sign in with GoodReads')
		expect(page).to have_content(quote.content)
		expect(page).to have_content(quote.author.name)
		expect(page).to have_content(quote.book.title)
	end
end