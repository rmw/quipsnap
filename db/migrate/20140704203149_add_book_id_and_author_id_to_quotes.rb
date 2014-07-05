class AddBookIdAndAuthorIdToQuotes < ActiveRecord::Migration
  def change
  	add_column :quotes, :book_id, :integer
  	add_column :quotes, :author_id, :integer
  end
end
