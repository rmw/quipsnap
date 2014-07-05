class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.belongs_to :user
      t.integer	:parent_id
      t.timestamps
    end
  end
end
