class BookclubQuote < ActiveRecord::Base
  belongs_to  :bookclub
  belongs_to  :quote
end
