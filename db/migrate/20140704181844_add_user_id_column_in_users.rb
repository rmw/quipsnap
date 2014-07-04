class AddUserIdColumnInUsers < ActiveRecord::Migration
  def change
  	add_column :users, :goodreads_user_id, :string
  end
end
