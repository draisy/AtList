# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
first_names = ["Kevin", "Dave", "Ian", "Sam", "Andrea", "Sarah", "Britney", "Martin", "Avi", "Courtney"]
last_names = ["Hyer", "Bratler", "Penn", "Aflick", "Joly", "Dunkins", "Adler", "Jenkins", "Mas", "Buyer"]

lists = ["best coffee in soho", "coffee in fidi", "coffee in midtown", "coffee in financial district", "coffee shops in soho", "cappucino and coffee in soho", "favorite coffee in west village", "cool west village coffee shops", "hip west village coffee spots", "favorite coffee in soho"] 

favorites = [{:name => "Ground Support", :description => "best cappucino spot for friends"},{:name => "Gregory's", :description => "rich espresso"},{:name => "Midtown Coffee", :description => "super quick and easy"},{:name => "BlueBottle", :description => "real Australian coffee"},{:name => "Aroma", :description => "pretty cool Israeli joint"},{:name => "Saturday's", :description => "hip Aussie spot"},{:name => "Whynot Cafe", :description => "trendy and delicious"},{:name => "West vil coffee", :description => "fun with friends"},{:name => "Draisy's coffee", :description => "home-brewed goodness"},{:name => "Francois Payard", :description => "French capital for coffee"}]

category = Category.create(:name => "coffee")

coffee_pics = ['coffee1.png', 'coffee2.png', 'coffee3.png', 'coffee4.png', 'coffee5.png', 'coffee6.png', 'coffee7.png', 'coffee8.png', 'coffee9.png', 'coffee10.png', 'coffee11.png', 'coffee12.png', 'coffee13.png', 'coffee14.png', 'coffee15.png', 'coffee16.png', 'coffee17.png', 'coffee18.png','coffee19.png', 'coffee20.png', 'coffee21.png', 'coffee22.png', 'coffee23.png', 'coffee24.png', 'coffee25.png', 'coffee26.png', 'coffee27.png','coffee28.png', 'coffee29.png', 'coffee30.png', 'coffee31.png', 'coffee32.png', 'coffee33.png', 'coffee34.png', 'coffee35.png', 'coffee36.png','coffee37.png', 'coffee38.png', 'coffee39.png', 'coffee40.png', 'coffee41.png', 'coffee42.png', 'coffee43.png', 'coffee44.png', 'coffee45.png','coffee46.png', 'coffee47.png', 'coffee48.png', 'coffee49.png', 'coffee50.png', 'coffee51.png', 'coffee52.png', 'coffee53.png', 'coffee54.png','coffee55.png', 'coffee56.png']

user_pics = ['user1.png', 'user2.png', 'user3.png', 'user4.png', 'user5.png', 'user6.png', 'user7.png', 'user8.png', 'user9.png', 'user10.png', 'user11.png', 'user12.png', 'user13.png', 'user14.png', 'user15.png', 'user16.png', 'user17.png', 'user18.png', 'user19.png', 'user20.png', 'user21.png', 'user22.png', 'user23.png', 'user24.png', 'user25.png', 'user26.png', 'user27.png']

i = 0
20.times do 
  u = User.new
  u.first_name = first_names.sample
  u.last_name = last_names.sample
  u.full_name = u.first_name + " " + u.last_name
  u.user_image = user_pics[i]
  i+=1
  l = List.new
  l.user = u
  l.title = lists.sample
  l.category = category
  u.save
  u.reload

  5.times do
    f = Favorite.new(favorites.sample)
    f.influence = Influence.create
    f.favorite_image = coffee_pics.sample
    f.list = l
      rand(20).times do 
        f.influence.pokes << Poke.create(:receiver_id => u.id, :giver_id => User.all.sample.id)
        f.influence.relists << Relist.create(:receiver_id => u.id, :giver_id => User.all.sample.id)
      end 
    f.save
    l.favorites << f
  end

  l.save
  u.lists << l
  u.save
end

Influence.all.each do |influence|
  influence.tabulate_score
  influence.save
end