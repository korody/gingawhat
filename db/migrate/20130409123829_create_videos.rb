class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.string :link
      t.string :description
      t.string :type
      t.integer :city_id
      t.belongs_to :filmable, polymorphic: true


      t.timestamps
    end
    add_index :videos, :filmable_id
  end
end
