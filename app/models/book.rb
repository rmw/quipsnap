class Book < ActiveRecord::Base
	validates :title, presence: true, uniqueness: true
	has_many :quotes

	def self.ransackable_attributes(auth_obj = nil)
		["title"]
	end
end
