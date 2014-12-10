class List < ActiveRecord::Base

  belongs_to :user
  belongs_to :category
  has_many :favorites
  has_many :influences, through: :favorites


  after_save :load_into_soulmate
  before_destroy :remove_from_soulmate


  # SEARCH------
  searchable do
    text :title

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

  def find_tags
    articles = %w(f a about above after again against all am an and any are aren't
as at be because been before being below between both but by can't cannot could couldn't did didn't do does doesn't doing don't down during each few for from further had hadn't has hasn't have haven't having he he'd he'll he's her here here's hers herself him himself his how how's i i'd i'll i'm i've if in into is isn't it it's its itself let's me more most mustn't my myself no nor not of off on once only or other ought our ours  ourselves out over own same shan't she she'd she'll she's should shouldn't so some such than that that's the their theirs them themselves then there there's these they they'd they'll they're they've this those through to too under until up very was wasn't we we'd we'll we're we've were weren't what what's when when's where where's which while who who's whom why why's with won't would wouldn't you you'd you'll you're you've your yours yourself yourselves )
  tags = favorites.collect do |favorite|
      favorite.name.split + self.title.split
    end
  tags.flatten.uniq.select{|tag| !articles.include?(tag)}
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
