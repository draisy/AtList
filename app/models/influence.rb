class Influence < ActiveRecord::Base

  belongs_to :favorite
  has_many :pokes
  has_many :relists

POKE_VALUE = 1
RELIST_VALUE = 2

def tabulate_score
  self.score = (get_pokes*POKE_VALUE) + (get_relists*RELIST_VALUE)
end

def get_pokes
  self.pokes.count
end

def get_relists
  self.relists.count
end
  
end
