class BookclubQuote < ActiveRecord::Base
  belongs_to  :bookclub
  belongs_to  :quote

  validates_uniqueness_of :bookclub_id, scope: :quote_id
end
