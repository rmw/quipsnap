class CreateQuoteFavorites < ActiveRecord::Migration
  def change
    create_table :quote_favorites do |t|
      t.belongs_to :quote
      t.belongs_to :user
      t.timestamps
    end
  end
end
