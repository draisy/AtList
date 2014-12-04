class Poke < ActiveRecord::Base

  belongs_to :influence
  belongs_to :receiver, :class_name => 'User'
  belongs_to :giver, :class_name => 'User'
  

  def favorite_poke
    
  end

end
