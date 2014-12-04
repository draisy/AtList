class Favorite < ActiveRecord::Base

  belongs_to :list
  has_one :influence
  has_many :pokes, through: :influence
  has_many :relists, through: :influence

  # SEARCH------
  searchable do 
    text :name, :boost => 2.0
    text :description 

    string  :sort_name do
      name.downcase.gsub(/^(an?|the)/, '')
    end
  end
  # END OF SEARCH



end
