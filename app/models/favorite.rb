class Favorite < ActiveRecord::Base

  belongs_to :list
  has_one :influence
  has_many :pokes, through: :influence
  has_many :relists, through: :influence

end
