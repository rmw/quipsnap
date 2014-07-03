class Quote < ActiveRecord::Base
	validates :content, presence: true
	validates :author, presence: true
	validates :title, presence: true
	belongs_to :user
end