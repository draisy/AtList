class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :title
      t.integer :user_id
      t.integer :category_id
      t.integer :list_score, :default => 0
      t.timestamps
    end
  end
end
