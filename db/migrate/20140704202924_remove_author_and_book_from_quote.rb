class RemoveAuthorAndBookFromQuote < ActiveRecord::Migration
  def change
  	remove_column :quotes, :author
  	remove_column :quotes, :title
  end
end
