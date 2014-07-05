require 'rails_helper'

feature 'Show Bookclubs', :js => true do

  let!(:bookclub) {create(:bookclub)}
  let(:user) {create(:user)}

  scenario 'user logged in' do
    allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit home_path
    click_button "Bookclubs"
    expect(current_path).to eq('/bookclubs')
    expect(page).to have_content(bookclub.name)
    expect(page).to have_content(bookclub.description)
  end

  scenario 'user not logged in' do
    visit '/bookclubs'
    expect(current_path).to eq(home_path)
  end

end