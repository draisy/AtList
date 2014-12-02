class CreateRelists < ActiveRecord::Migration
  def change
    create_table :relists do |t|
      t.integer :influence_id
      t.integer :receiver_id
      t.integer :giver_id
      t.timestamps
    end
  end
end
