class User < ActiveRecord::Base
  validates :goodreads_name, presence: true, uniqueness: true
  validates :auth_token, presence: true
  validates :auth_secret, presence: true
  has_many :quotes

end
