class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :comment
      t.integer :user_id
      t.integer :gram_id
      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :gram_id
  end
end
