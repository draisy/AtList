class AddTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string, :limit => nil
  end
end
