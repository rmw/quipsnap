class QuoteFavorite < ActiveRecord::Base
	belongs_to :user
	belongs_to :quote

	validates_uniqueness_of :user_id, scope: :quote_id
end
