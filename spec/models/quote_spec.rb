require 'rails_helper'

describe Quote do
	it "has a valid factory" do
		expect(build(:quote)).to be_valid
	end

	it "is invalid without content" do
		expect(build(:quote, content: nil)).to have(1).errors_on(:content)
	end

	it "is invalid without a title" do
		expect(build(:quote, title: nil)).to have(1).errors_on(:title)
	end

	it "is invalid without an author" do
		expect(build(:quote, author: nil)).to have(1).errors_on(:author)
	end

	it "should belong to a user" do
		expect(build(:quote)).to respond_to :user
	end
end