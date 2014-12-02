class CreateInfluences < ActiveRecord::Migration
  def change
    create_table :influences do |t|
      t.integer :favorite_id

      t.timestamps
    end
  end
end
