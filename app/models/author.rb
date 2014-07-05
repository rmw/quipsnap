class Author < ActiveRecord::Base
	validates :name, presence: :true
	has_many :quotes

	def self.ransackable_attributes(auth_obj = nil)
		["name"]
	end
end
