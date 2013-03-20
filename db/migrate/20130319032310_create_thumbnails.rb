class CreateThumbnails < ActiveRecord::Migration
  def change
    create_table :thumbnails do |t|
      t.string :thumb
      t.belongs_to :thumbable, polymorphic: true

      t.timestamps
    end
    add_index :thumbnails, :thumbable_id
  end
end