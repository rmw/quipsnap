require 'rails_helper'

RSpec.describe Author, :type => :model do

	it "has a valid factory" do
		expect(build(:author)).to be_valid
	end

	it "is invalid without a name" do
		expect(build(:author, name: nil)).to have(1).errors_on(:name)
	end

	it "is invalid with a duplicate name" do
		create(:author, name: "dave")
		expect(build(:author, name: "dave")).to have(1).errors_on(:name)
	end

	it "only allows author name for ransackable attributes (quotes filter)" do
		expect(Author.ransackable_attributes).to eq(["name"])
	end
end
