class Bookclub < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  has_many  :bookclub_quotes
  has_many  :quotes, through: :bookclub_quotes
  has_many  :memberships
  has_many  :users, through: :memberships

  belongs_to  :admin, class_name: "User", foreign_key: :user_id
end
