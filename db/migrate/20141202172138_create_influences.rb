class CreateInfluences < ActiveRecord::Migration
  def change
    create_table :influences do |t|
      t.integer :score, :default => 0
      t.integer :favorite_id

      t.timestamps
    end
  end
end
