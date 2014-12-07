class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :user_image
      t.string :email
      t.string :provider
      t.string :uid
      t.integer :user_score, default: 0
      t.timestamps
    end
  end
end
