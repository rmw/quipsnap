require 'rails_helper'

RSpec.describe BookclubQuote, :type => :model do

  let(:bookclub_quote) { build(:bookclub_quote) }

  it "has a valid factory" do
    expect(bookclub_quote).to be_valid
  end

  it "belongs to a bookclub" do
    expect(bookclub_quote).to respond_to :bookclub
  end

  it "belongs to a quote" do
    expect(bookclub_quote).to respond_to :quote
  end
  
end
