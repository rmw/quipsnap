class Membership < ActiveRecord::Base
  belongs_to  :bookclub
  belongs_to  :user
end
