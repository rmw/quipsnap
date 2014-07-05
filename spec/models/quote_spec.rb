require 'rails_helper'

RSpec.describe Quote, :type => :model do

	it "has a valid factory" do
		expect(build(:quote)).to be_valid
	end

	it "is invalid without content" do
		expect(build(:quote, content: nil)).to have(1).errors_on(:content)
	end

	it "should belong to a user" do
		expect(build(:quote)).to respond_to :user
	end

	it "should belong to an author" do
		expect(build(:quote)).to respond_to :author
	end

	it "should belong to a book" do
		expect(build(:quote)).to respond_to :book
	end

	it "only allows author for ransackable attributes (quotes filter)" do
		expect(Quote.ransackable_attributes).to eq([])
	end
	
	it "only allows user for ransackable associations (quotes filter)" do
		expect(Quote.ransackable_associations).to eq(["user", "author", "book"])
	end
end