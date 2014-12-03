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

  def user_friends
    friends = FacebookWrapper.new(self.token).get_friends
    friends.collect {|friend| User.find_by_uid(friend[:uid]) }
  end

  def user_friends_by_name
    user_objects = user_friends
    user_objects.collect do |user|
      user.first_name
    end
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
      user.user_image = auth["info"]["image"]
    end
  end

  def self.koala(auth, user)
    access_token = auth['credentials']['token']
    facebook = Koala::Facebook::API.new(access_token)
    user_attrs = facebook.get_object("me?fields=first_name, last_name, email, picture")
    user_friends = facebook.get_connections("me", "friends")


    user.first_name = user_attrs["first_name"]
    user.last_name = user_attrs["last_name"]
    user.user_image = user_attrs["picture"]["data"]["url"]
    user.email = user_attrs["email"]

    # add data attrs you want to get
  end


end
