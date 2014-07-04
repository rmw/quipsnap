class User < ActiveRecord::Base
  validates :goodreads_name, presence: true, uniqueness: true
  validates :auth_token, presence: true
  validates :auth_secret, presence: true
  has_many :quotes


	# Only allow users to use Ransack to search quotes by user's username
	def self.ransackable_attributes(auth_obj = nil)
		["username"]
	end

end
