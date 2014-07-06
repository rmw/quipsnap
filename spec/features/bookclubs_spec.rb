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

feature 'Join Bookclubs', :js => true do
  let!(:bookclub) {create(:bookclub)}
  let(:user) {create(:user)}

  scenario 'is successful' do
    allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit bookclubs_path
    click_button "+"
    wait_for_ajax_to_finish
    expect(page).to_not have_selector('bookclub-join');
  end

end

feature 'Add Bookclubs', :js => true do
  let(:bookclub) {build(:bookclub)}
  let(:user) {create(:user)}

  scenario 'with a valid bookclub' do
    allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit bookclubs_path
    fill_in 'Name', with: bookclub.name
    fill_in 'Description', with: bookclub.description
    click_button "Create new club"
    wait_for_ajax_to_finish
    expect(page).to have_content(bookclub.name)
    expect(page).to have_content(bookclub.description)
  end

  scenario 'with invalid bookclub' do
    bookclub = build(:bookclub, name: '')
    allow_any_instance_of(ApplicationController).to receive(:logged_in?).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit bookclubs_path
    fill_in 'Name', with: bookclub.name
    fill_in 'Description', with: bookclub.description
    click_button "Create new club"
    wait_for_ajax_to_finish
    expect(page).to_not have_content(bookclub.description)
  end

end