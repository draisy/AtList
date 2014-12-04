class Category < ActiveRecord::Base

  has_many :lists
  has_many :user_categories
  has_many :users, through: :user_categories
  has_many :favorites, through: :lists


  def get_category_influence
    category_score = self.lists.collect do |list| 
      list.get_list_influence
    end
    category_score.inject(:+)
  end

  # SEARCH------
  searchable do
    text :name, :boost => 2.0

    string :sort_name do 
      name.downcase.gsub(/^(an?|the)/, '')
    end
  end
# END OF SEARCH

end


