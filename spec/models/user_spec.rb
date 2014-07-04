require 'rails_helper'

RSpec.describe User, :type => :model do

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without a username" do
    expect(build(:user, username: nil)).to have(1).errors_on(:username)
  end

  it "is invalid without an auth_token" do
    expect(build(:user, auth_token: nil)).to have(1).errors_on(:auth_token)
  end

  it "is invalid without an auth_secret" do
    expect(build(:user, auth_secret: nil)).to have(1).errors_on(:auth_secret)
  end

  it "is invalid with a duplicate username" do
    create(:user)
    expect(build(:user, username: nil)).to have(1).errors_on(:username)
  end

  it "has many quotes" do
    expect(build(:user)).to respond_to :quotes
  end
  
  it "only allows username for ransackable attributes (quotes filter)" do
    expect(User.ransackable_attributes).to eq(["username"])
  end

end
