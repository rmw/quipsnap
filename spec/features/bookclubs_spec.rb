require 'rails_helper'

feature 'Show Bookclubs', :js => true do

  let(:bookclub) {create(:bookclub)}
  let(:user) {create(:user)}

  ##########Will come back to this, need to figure out how to stub a session
  # scenario 'user logged in' do
  #   session[:user_id]
  #   visit home_path
  #   click_button "Bookclubs"
  #   expect(current_path).to eq('/bookclubs')
  #   expect(page).to have_content(bookclub.name)
  #   expect(page).to have_content(bookclub.description)
  # end

  scenario 'user not logged in' do
    visit '/bookclubs'
    expect(current_path).to eq(home_path)
  end

end