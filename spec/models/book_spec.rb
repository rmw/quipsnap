require 'rails_helper'

RSpec.describe Book, :type => :model do
	it "has a valid factory" do
		expect(build(:book)).to be_valid
	end

	it "is invalid without a title" do
		expect(build(:book, title: nil)).to have(1).errors_on(:title)
	end

	it "is invalid with a duplicate title" do
		create(:book, title: "hey there")
		expect(build(:book, title: "hey there")).to have(1).errors_on(:title)
	end
end
