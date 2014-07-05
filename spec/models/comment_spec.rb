require 'rails_helper'

RSpec.describe Comment, :type => :model do
	it "has a valid factory" do
		expect(build(:comment)).to be_valid
	end

	it "is invalid without content" do
		expect(build(:comment, content: nil)).to have(1).errors_on(:content)
	end

	it "is invalid without a user" do
		expect(build(:comment, user: nil)).to have(1).errors_on(:user)
	end

	it "should belong to a user" do
		expect(build(:comment)).to respond_to :user
	end
end
