class Influence < ActiveRecord::Base

  belongs_to :favorite
  has_many :pokes
  has_many :relists
  
end
