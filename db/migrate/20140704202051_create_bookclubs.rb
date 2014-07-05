class CreateBookclubs < ActiveRecord::Migration
  def change
    create_table :bookclubs do |t|
      t.string      :name
      t.string      :description

      t.belongs_to  :user

      t.timestamps
    end
  end
end
