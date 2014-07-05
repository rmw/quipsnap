require 'rails_helper'

RSpec.describe QuotesController, :type => :controller do
	describe "#search" do
		context "when searching for quotes" do
			let!(:quote) { create(:quote) }
			let!(:quote_2) { create(:quote) }

			it "expects response to be successful" do
				post :search
				expect(response).to be_success
			end

			it "renders the index page" do
				post :search
				expect(response).to render_template("users/index")
			end

			it "assigns @quotes to quotes" do
				post :search, q: {book_title_cont: quote.book.title, author_name_cont: quote.author.name, user_goodreads_name_cont: quote.user.goodreads_name}
				expect(assigns(:quotes)).to eq [quote] 
			end
			
		end
	end
end
