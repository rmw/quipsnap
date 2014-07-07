require 'rails_helper'

RSpec.describe QuoteFavorite, :type => :model do
  let(:quote_favorite) { build(:quote_favorite) }

  it "has a valid factory" do
    expect(quote_favorite).to be_valid
  end

  it "belongs to a user" do
    expect(quote_favorite).to respond_to :user
  end

  it "belongs to a quote" do
    expect(quote_favorite).to respond_to :quote
  end

  it "must have unique bookclub_id and quote_id values" do
    create(:quote_favorite, user_id: 1, quote_id: 1)
    expect(build(:quote_favorite, user_id: 1, quote_id: 1)).to have(1).errors_on(:user_id)
  end

end
