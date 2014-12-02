class Favorite < ActiveRecord::Base

  belongs_to :list
  has_one :influence

end
