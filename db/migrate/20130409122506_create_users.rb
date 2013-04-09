class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.text :bio
      t.string :facebook
      t.string :instagram
      t.string :twitter
      t.string :social
      t.string :website
      t.string :type

      t.timestamps
    end
  end
end
