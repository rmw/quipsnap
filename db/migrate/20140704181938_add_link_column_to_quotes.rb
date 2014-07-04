class AddLinkColumnToQuotes < ActiveRecord::Migration
  def change
  	add_column :quotes, :goodreads_link, :string
  end
end
