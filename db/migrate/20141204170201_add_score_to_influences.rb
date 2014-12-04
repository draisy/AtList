class AddScoreToInfluences < ActiveRecord::Migration
  def change
    add_column :influences, :score, :integer
  end
end
