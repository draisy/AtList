class CreatePokes < ActiveRecord::Migration
  def change
    create_table :pokes do |t|
      t.integer :influence_id
      t.integer :receiver_id
      t.integer :giver_id

      t.timestamps
    end
  end
end
