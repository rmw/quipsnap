require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
	describe "post#create" do
		let!(:user) { create(:user) }
		let!(:quote) { create(:quote) }

		it "creates a new comment object" do
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)	  	
			post :create, comment: "this is a comment", quote_id: quote.id
			expect(assigns(:comment)).to be_a Comment	
		end

		it "returns success message when comment is saved" do
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
			post :create, comment: "this is a comment", quote_id: quote.id
			expect(assigns(:success_or_fail_message)).to eq "Comment Saved Successfully"
		end

		it "returns failure message when comment is not saved" do
			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
			post :create, comment: "", quote_id: quote.id
			expect(assigns(:success_or_fail_message)).to eq "Unable to Save Comment"
		end

	end
end




