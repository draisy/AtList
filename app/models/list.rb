class List < ActiveRecord::Base

  belongs_to :user
  belongs_to :category
  has_many :favorites
  has_many :influences, through: :favorites


  after_save :load_into_soulmate
  before_destroy :remove_from_soulmate


  # SEARCH------
  searchable do 
    text :title, :boost => 2.0

    string :sort_title do
      title.downcase.gsub(/^(an?|the)/, '')
    end
  end 

  # END OF SEARCH

  def assign_triggers(triggers)
    triggers = triggers.uniq.reject {|t| t.empty? }
    triggers.each do |t|
      self.favorites.build(:name => t[:name], :description => t[:description], :favorite_image => t[:image]).save
    end
  end


  def get_list_influence_objects
    self.list_score = get_list_influence
    self.save
    self
  end

  def get_list_influence
      list_agg = self.favorites.collect do |fav|
        fav.influence.tabulate_score 
      end
    list_agg.inject(:+)
  end

  def get_list_pokes_count
    list_pokes_agg = self.favorites.collect do |fav|
      fav.influence.get_pokes 
    end
    list_pokes_agg.inject(:+)
  end

  def get_list_relists_count
    list_relists_agg = self.favorites.collect do |fav|
      fav.influence.get_relists 
    end
    list_relists_agg.inject(:+)
  end

  private 
    def load_into_soulmate
    loader = Soulmate::Loader.new("lists")
    loader.add("term" => title, "id" => self.id
      # , "data" => {
      # "link" => Rails.application.routes.url_helpers.user_list_path(self.user, self)
      # }
      )
    end
 
    def remove_from_soulmate
      loader = Soulmate::Loader.new("lists")
        loader.remove("id" => self.id)
    end

end
