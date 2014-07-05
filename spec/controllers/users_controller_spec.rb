require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
	describe "GET #index" do
		context "when visiting as a guest" do
			it "expects response to be successful" do
				get :index
				expect(response).to be_success
			end

			it "assigns quotes in descending chrono order to @quotes" do
				get :index
				quotes = Quote.all.order("created_at DESC")
				expect(assigns(:quotes)).to eq quotes
			end
		end
	end
end
