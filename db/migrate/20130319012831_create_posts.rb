class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :city_id

      t.timestamps
    end
    add_index :posts, [:user_id, :created_at]
  end
end
