class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.string :name
      t.string :description
      t.string :favorite_image
      t.integer :list_id
      t.timestamps
    end
  end
end
