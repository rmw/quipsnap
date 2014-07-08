class ChangeUsernameColumnInUsersTable < ActiveRecord::Migration
  def change
  	rename_column :users, :username, :goodreads_name
  end
end
