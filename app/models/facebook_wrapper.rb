class FacebookWrapper

  attr_reader :client

  def initialize(auth_token)
    @client = Koala::Facebook::API.new(auth_token)
  end

  def get_friends
    client.get_connections("me", "friends")
  end
    
end