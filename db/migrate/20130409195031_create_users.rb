class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :title
      t.text :bio
      t.string :facebook
      t.string :twitter
      t.string :instagram
      t.string :social
      t.string :website
      t.string :type
      t.integer :city_id
      t.string :password_digest
      t.string :remember_token
      t.string :password_reset_token
      t.datetime :password_reset_sent_at

      t.timestamps
    end
  end
end
