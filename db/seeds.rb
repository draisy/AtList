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


20.times do 
  u = User.new
  u.first_name = first_names.sample
  u.last_name = last_names.sample
  u.full_name = u.first_name + " " + u.last_name
  l = List.new
  l.user = u
  l.title = lists.sample
  l.category = category
  u.save
  u.reload

  5.times do
    f = Favorite.new(favorites.sample)
    f.influence = Influence.create
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