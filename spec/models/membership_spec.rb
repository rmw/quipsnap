require 'rails_helper'

RSpec.describe Membership, :type => :model do

  let(:membership) { build(:membership) }

  it "has a valid factory" do
    expect(membership).to be_valid
  end

  it "belongs to a bookclub" do
    expect(membership).to respond_to :bookclub
  end

  it "belongs to a user" do
    expect(membership).to respond_to :user
  end
  
end
