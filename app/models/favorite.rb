class Favorite < ActiveRecord::Base

  belongs_to :list
  has_one :influence
  has_many :pokes, through: :influence
  has_many :relists, through: :influence

  # after_save :load_into_soulmate
  # before_destroy :remove_from_soulmate

  # SEARCH------
  searchable do 
    text :name, :boost => 2.0
    text :description 

    string  :sort_name do
      name.downcase.gsub(/^(an?|the)/, '')
    end
  end
  # END OF SEARCH


    # private 

    # def load_into_soulmate
    # loader = Soulmate::Loader.new("favorites")
    # loader.add("term" => name, "id" => self.id, "data" => {
    #   "link" => Rails.application.routes.url_helpers.user_list_path(self.list.user, self.list)
    #   }
    #   )
    # end
 
    # def remove_from_soulmate
    #   loader = Soulmate::Loader.new("favorites")
    #     loader.remove("id" => self.id)
    # end


end
