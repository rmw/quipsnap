class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.text        :content
      t.string      :author
      t.string      :title

      t.belongs_to  :user

      t.timestamps
    end
  end
end
