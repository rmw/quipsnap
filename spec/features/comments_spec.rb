require 'rails_helper'

feature 'Adding comments to a quote', :js => true do
	let!(:user) { create(:user) }

	scenario 'when not logged in cannot post a comment' do
		allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(false)
		quote = create(:quote)
		visit home_path
		expect(page).to_not have_button('Add Comment')
	end

	scenario 'when logged in you can add a comment' do
		allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(true)
		allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
		quote = create(:quote)
		user.quotes << quote
		visit home_path
		expect(page).to have_button('Add Comment')
		click_button 'Add Comment'
		expect(page).to have_selector('form.comment-form')
		fill_in 'comment', with: 'this is a comment'
		click_button "Submit Comment"
		wait_for_ajax_to_finish
		expect(page).to have_button('Add Comment')
		expect(page).to_not have_content("this is a comment")
	end

end