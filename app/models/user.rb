class User < ActiveRecord::Base

  has_many :lists
  has_many :favorites, through: :lists
  has_many :user_categories
  has_many :categories, through: :user_categories

  #RECEIVER
  has_many :pokes, :foreign_key => 'receiver_id'
  has_many :relists, :foreign_key => 'receiver_id'

  #GIVER
  has_many :pokes, :foreign_key => 'giver_id'
  has_many :relists, :foreign_key => 'giver_id'

  after_save :load_into_soulmate
  before_destroy :remove_from_soulmate


  # SEARCH------
  searchable do 
    text :first_name, :boost => 2.0
    text :last_name
    text :email  

    string :sort_first_name do 
      first_name.downcase
    end 

    string :sort_last_name do 
      last_name.downcase.gsub(/^(an?|the)/, '')
    end
  end
  # END OF SEARCH


  def user_friends
    friends = FacebookWrapper.new(self.token).get_friends
    friends.collect! {|friend| User.find_by_uid(friend["id"]) }
  end

  # def user_friends_lists
  #   user_objects = user_friends
  #   user_lists = user_objects.collect do |user| 
  #     user.lists 
  #   end
  # end

  def user_friends_lists
    user_objects = user_friends
    user_lists = []
    user_objects.each do |user|
      if user  
        user_lists << user.lists 
      end
    end
    user_lists
  end

  def user_friends_by_name
    user_objects = user_friends
    user_objects.collect! do |user|
      user.first_name
    end
  end

  def count_total_favorites
    self.favorites.count
  end

  def count_total_upvotes
    upvote_count_array = self.favorites.collect do |fav|
      fav.influence.get_pokes
    end
    upvote_count_array.inject(:+)
  end

  def count_total_relists
    relist_count_array = self.favorites.collect do |fav|
      fav.influence.get_relists
    end
    relist_count_array.inject(:+)
  end

  def user_influence_across_lists_objects
    self.user_score = user_influence_across_lists
    self.save
    self
  end

  def user_influence_across_lists
    list_agg = lists.collect do |list|
      list.get_list_influence
    end
      list_agg.inject(:+)
  end

  # def user_influence_on_particular_category_objects?
    # NEED TO CREATE A METHOD FOR THIS?
  # end

  def user_influence_on_particular_category(category)
    lists = get_user_lists_in_category(category)
    list_agg = lists.collect do |list|
      list.get_list_influence
    end
      list_agg.inject(:+)
  end

  def get_user_lists_in_category(category)
    self.lists.where(:category_id => category.id)
  end

  def self.create_with_omniauth_and_koala(auth)
    create! do |user|

      User.koala(auth, user)
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.token = auth['credentials']['token']

      user.first_name = auth["info"]["first_name"]
      user.last_name = auth["info"]["last_name"]
      user.email = auth["info"]["email"]
      user.user_image = auth["info"]["image"] + "?type=large"
    end
  end

  def self.koala(auth, user)
    access_token = auth['credentials']['token']
    facebook = Koala::Facebook::API.new(access_token)
    user_attrs = facebook.get_object("me?fields=first_name, last_name, email, picture")
    user_friends = facebook.get_connections("me", "friends")


    user.first_name = user_attrs["first_name"]
    user.last_name = user_attrs["last_name"]
    user.full_name = user_attrs["first_name"] + " " + user_attrs["last_name"]
    user.user_image = user_attrs["picture"]["data"]["url"]
    user.email = user_attrs["email"]

  end

  private 

    def load_into_soulmate
    loader = Soulmate::Loader.new("users")
    loader.add("term" => full_name, "id" => self.id, "data" => {
      "link" => Rails.application.routes.url_helpers.user_path(self)
      })
    end
 
    def remove_from_soulmate
      loader = Soulmate::Loader.new("users")
        loader.remove("id" => self.id)
    end


end
