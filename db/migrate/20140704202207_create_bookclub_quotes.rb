class CreateBookclubQuotes < ActiveRecord::Migration
  def change
    create_table :bookclub_quotes do |t|
      t.belongs_to    :bookclub
      t.belongs_to    :quote

      t.timestamps
    end
  end
end
