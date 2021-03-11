require 'json'
require 'open-uri'

FAKE_PHOTO_KEYS = ['t7auff31619mxl1upagdor7ts49h', 'r5yi22rom7u5i86qyvd7f30xp5be', 'haeklfd1jpjpzveknymdcu7n2llz', 'dzxog7b6f4359kj72nichqj11oqo', 'hoj8c73fri6li3gnidhiomo79wl1', 'wq4si0kpvju2hjjujskkf8agylsh', 'fsv8q7lstx7fhqyp95af82wfefz6', 'of849kaxtcsx5zto0sycaci13zpw', 'lrlty5g41av5s9ph05wkulf10h57', 'x1ic3frq0v22he6ds916hvs45btw', 't8msc5qhbgv99ver5mworgrkhd5w', '9cgq5usdus2ndn5bjzbg7iyl0mnl', 'puh67e3o6qlxeov9z9tblfrnnqfo', 'hqkcc544zqmvvl0uv7uh6tgcgs97', 'beh0e03gw66nsmyaos3n3ba65ydv', 'y8qax4pz6qnznju6lrod8tt8jg01', 'p5nb4cgduoroz2c0dzjq6xn5nkxn', '260lem09cg206nlm0whcwh9a3gal', 'kg4vj32i2df003gbr5pu76r2g4tb', 'x0u0z4zwcwmd0cafvszdm8zbxvgh', 'ee2ezn80pi36lkhz6f9h01hizsiy', 'mog6f3161waf7hzvr1vudczpeump', 'alczoz4fa7ma7lmdhrclwj5fky9k', 'bh64elc8pq6ux9impr9vfxl8hhks', '0u47d3qblam8wcy4yr97fe4q6tzi', '55ojbrg5a9ax9ygcvfqlghyw5b68', '917zo22wttg1dtnge2xytvsz43yt', 'xbihz4x4isy7vzamfv3tz0ngbx1g', '45qss537ozknvhd0fr9paaqrkw3r', 'z5jze6sdk426cwxbkh2kzfvpj1sh', '7cscll5bmw91vqopx0ae1e88mmp7', '3qxkm0nu5rc1t3fw37h0gysppvj9', '8m682utdp9sl7zmespnxxvbyfgzc', 'jqhx73sv7idn0d1clcnlxcr0hdh3']

def load_lith_with_photo(lith)
  new_lith = Megalith.new(
    name: lith['name'],
    category: lith['category'],
    description: lith['description'],
    latitude: lith['latitude'],
    longitude: lith['longitude']
  )
  p new_lith.name
  p new_lith.save
  img_file = URI.open(lith['imgurl'])
  filetype = lith['imgurl'].split('.').last
  img = MegalithPhoto.new
  img.photo.attach(io: img_file, filename: "lith.#{filetype}", content_type: 'image/png')
  img.megalith = new_lith
  img.user = @photoadmin
  p img.save
end

def load_lith_without_photo(lith)
  new_lith = Megalith.new(
    name: lith['name'],
    category: lith['category'],
    description: lith['description'],
    latitude: lith['latitude'],
    longitude: lith['longitude']
  )
  p new_lith.name
  p new_lith.save
end

# THIS WILL ONLY WORK IF ON ARFA.CAMBLE CLOUDINARY
def load_lith_with_fake_photo(lith)
  new_lith = Megalith.new(
    name: lith['name'],
    category: lith['category'],
    description: lith['description'],
    latitude: lith['latitude'],
    longitude: lith['longitude']
  )
  p new_lith.name
  new_lith.fake_photo_key = FAKE_PHOTO_KEYS.sample
  p new_lith.save
end

p 'deleting users, liths and trips'
Favourite.destroy_all
Visited.destroy_all
OtherLocation.destroy_all
Comment.destroy_all
Rating.destroy_all
TripPhoto.destroy_all
MegalithPhoto.destroy_all
Trip.destroy_all
User.destroy_all
Megalith.destroy_all
p 'some new users:'

def attach_avatar(user, img_url)
  avatar_img = URI.open(img_url)
  user.photo.attach(io: avatar_img, filename: "avatar.jpg", content_type: 'image/png')
end

def make_ratings_and_comments_and_upvotes(user)
  megaliths = Megalith.all
  megaliths.sample(megaliths.size * 0.6).each do |lith|
    p lith.name
    Visited.create(user: user, megalith: lith)
    Rating.create(score: rand(1..5), user: user, megalith: lith)
    Comment.create(text: "#{Faker::Music::RockBand.name}. #{Faker::Hipster.paragraph(sentence_count: 3)}", user: user, megalith: lith )
    comments = Comment.all
    comments.sample(comments.size * 0.7).each do |comment|
      comment.liked_by user
    end
    photos = MegalithPhoto.all
    photos.sample(photos.size * 0.5).each do |photo|
      photo.liked_by user
    end
    trips = Trip.all
    trips.sample(trips.size * 0.7).each do |trip|
      trip.liked_by user
    end
  end
end

brian = User.create(email: 'brian@internet.com', password: 'password', username: 'Brian LithLegend')
attach_avatar(brian, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcReSqEhw-txJbZQc80W8nIJkrm848vAAYUb6Q&usqp=CAU')
noobles = User.create(email: 'rocknoob@test.com', password: 'password', username: 'Noob on the Rocks')
attach_avatar(noobles, 'https://i.dailymail.co.uk/i/pix/2017/04/20/13/3F6B966D00000578-4428630-image-m-80_1492690622006.jpg')
david = User.create(email: 'david@test.com', password: 'password', username: 'David Stone Man')
attach_avatar(david, 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
peter = User.create(email: 'peter@internet.com', password: 'password', username: 'Peat ;)')
attach_avatar(peter, 'https://image1.masterfile.com/getImage/NzAwLTAwMDU1NjQ2ZW4uMDAwMDAwMDA=ALrv8s/700-00055646en_Masterfile.jpg')
gertrude = User.create(email: 'gertrude@internet.com', password: 'password', username: 'Gertie')
attach_avatar(gertrude, 'https://t4.ftcdn.net/jpg/03/16/16/21/360_F_316162176_3SEzHnxKzb8EUDTnfKGXePmQ6Em2xaaq.jpg')
@photoadmin = User.create(email: 'photographer@test.com', password: 'password', username: 'Stone cold Snapper')
attach_avatar(@photoadmin, 'https://www.davidnoton.com/public/images/Home/david-new.jpg')

USERS = [noobles, david, peter, gertrude, @photoadmin]

def make_trips(user)
  3.times do
    lith = Megalith.find(Megalith.pluck(:id).sample)
    trip = Trip.create(name: Faker::Compass.quarter_wind + " to " + Faker::Ancient.primordial, tagline: Faker::Music::RockBand.name, top_tip: Faker::Food.measurement + " of " + Faker::Beer.style, description: Faker::Hipster.paragraph(sentence_count: 3), date_visited: Faker::Date.between(from: 1.year.ago, to: Date.yesterday), published: true)
    TripUser.create(trip: trip, user: user)
    other_user = USERS.reject {|u| u == user}.sample
    TripUser.create(trip: trip, user: other_user)
    TripMegalith.create(trip: trip, megalith: lith, main: true)
  end
end

p 'users in the bag. time for some liths'

dorset_file_relative = "./seed-play/Dorset-v3-latlong-formatted.json"
dorset_final = "./seed-play/Dorset-final.json"
devon_file_relative = "./seed-play/Devon-v3-latlong-formatted.json"
somerset_file_relative = "./seed-play/Somerset-v3-latlong-formatted.json"
all_three = [dorset_file_relative, devon_file_relative, somerset_file_relative]
def hash_of_liths_from_json(relative_filepath)
  json_file = File.join(File.dirname(__FILE__), relative_filepath)
  liths = JSON.parse(File.read(json_file))
end
# # # # OPTIONS --- PICK ONE ONLY
# # 1 load 20 with photos
# # hash_of_liths_from_json(dorset_file_relative).first(40).each { |lith| load_lith_with_photo(lith) }

# # 2 load all with photos - expensive for cloudinary, will take a long time
# # all_three.each do |filepath|
# #   hash_of_liths_from_json(filepath).each { |lith| load_lith_with_photo(lith) }
# # end

# # 3 load all without photos - good to practise with pagination and lots of stuff on the map
# # all_three.each do |filepath|
# #   hash_of_liths_from_json(filepath).each { |lith| load_lith_without_photo(lith) }
# # end

# # 4 load somerset with photos and devon/dorset without - maybe a good balance for the final presentation?
# # hash_of_liths_from_json(somerset_file_relative).each { |lith| load_lith_with_photo(lith) }
# # hash_of_liths_from_json(devon_file_relative).each { |lith| load_lith_without_photo(lith) }
# # hash_of_liths_from_json(dorset_file_relative).each { |lith| load_lith_without_photo(lith) }

# # 5 load somerset with photos and devon/dorset with fakes - WILL ONLY WORK WITH ARFA.CAMBLE CLOUDINARY
# # hash_of_liths_from_json(somerset_file_relative).each { |lith| load_lith_with_photo(lith) }
# # hash_of_liths_from_json(devon_file_relative).each { |lith| load_lith_with_fake_photo(lith) }
# # hash_of_liths_from_json(dorset_file_relative).each { |lith| load_lith_with_fake_photo(lith) }

# # # 6 load all with fakes - WILL ONLY WORK WITH ARFA.CAMBLE CLOUDINARY
# # hash_of_liths_from_json(somerset_file_relative).each { |lith| load_lith_with_fake_photo(lith) }
# # hash_of_liths_from_json(devon_file_relative).each { |lith| load_lith_with_fake_photo(lith) }
# hash_of_liths_from_json(dorset_file_relative).each { |lith| load_lith_with_fake_photo(lith) }

# FINAL
hash_of_liths_from_json(dorset_final).first(40).each { |lith| load_lith_with_photo(lith) }

p 'liths loaded'

# trips and comments should be auto-generated once we know which megaliths
# we want to use in our demo OR we make some ourselves leading up to the demo

p 'creating random favourites and visiteds for brian'

all_liths = Megalith.all
all_liths.sample(5).each do |megalith|
  Favourite.create(megalith: megalith, user: brian)
end
all_liths.sample(15).each do |megalith|
  Visited.create(megalith: megalith, user: brian)
end

p 'some photo uploads for big bri and likes from chums'
clandon = Megalith.find_by_name("Clandon Barrow")
clandon_img_file = URI.open('https://historicengland.org.uk/etl/1015781/5cd574d0-bb2a-496b-a244-4a3931482917.jpg')
img = MegalithPhoto.new
img.photo.attach(io: clandon_img_file, filename: "lith.jpg", content_type: 'image/png')
img.megalith = clandon
img.user = brian
p img.save
[noobles, david, peter, gertrude].each { |u| img.liked_by u }

maiden_castle = Megalith.find_by_name("Maiden Castle (Dorset)")
maiden_img_file = URI.open("https://assets.simpleview-europe.com/dorset2016/imageresizer/?image=%2Fdmsimgs%2FMaiden_Castle_531161138.jpg&action=ProductDetail")
img = MegalithPhoto.new
img.photo.attach(io: maiden_img_file, filename: "lith.jpg", content_type: 'image/png')
img.megalith = maiden_castle
img.user = brian
p img.save
[noobles, peter, gertrude].each { |u| img.liked_by u }

hengistbury = Megalith.find_by_name("Hengistbury Head")
img_file = URI.open("https://www.visitbournemouth.com/media/zoo/images/HengistburyHead_e6cfac90bf47ee0bb6d6c10edaae4a21.JPG")
img = MegalithPhoto.new
img.photo.attach(io: img_file, filename: "lith.jpg", content_type: 'image/png')
img.megalith = maiden_castle
img.user = brian
p img.save
[noobles, gertrude].each { |u| img.liked_by u }

p 'a couple of trips in the past'
trip = Trip.new(name: "Stroll up Maiden Castle", tagline: "EPIC hillfort", top_tip: "The Red Lion nearby serves great ales", description: "There's no way to get a visit to this spectacular hillfort wrong. If you're lucky and it's a clear day you'll see a good distance. Don't forget your thermos, you can sit up on Maiden Castle drinking tea for hours.", date_visited: 'Tue, 02 Mar 2021', published: true)
p 1
TripUser.create(trip: trip, user: brian)
TripUser.create(trip: trip, user: noobles)
TripMegalith.create(trip: trip, megalith: maiden_castle, main: true)
p 2
maiden_img = TripPhoto.new(trip: trip)
maiden_img_file_two = URI.open("https://assets.simpleview-europe.com/dorset2016/imageresizer/?image=%2Fdmsimgs%2FMaiden_Castle_531161138.jpg&action=ProductDetail")
maiden_img.photo.attach(io: maiden_img_file_two, filename: "lith.jpg", content_type: 'image/png')
maiden_img.save
p trip.save

trip = Trip.create(name: "Around the Clandon Barrow", tagline: "Big historic mound", top_tip: "The White Hart down the road has great homemade sausage rolls", description: "This is a great big mound of earth and there's sure to be all sorts of history hidden inside. I took along my metal detector and found a ha'penny bit so I bet there's neolithic stone currency somewhere. Good luck!", date_visited: 'Tue, 09 Mar 2021', published: true)
TripUser.create(trip: trip, user: brian)
TripUser.create(trip: trip, user: peter)
TripUser.create(trip: trip, user: gertrude)
TripMegalith.create(trip: trip, megalith: clandon, main: true)
TripMegalith.create(trip: trip, megalith: Megalith.find_by_name("Maumbury Rings"))
clandon_img = TripPhoto.new(trip: trip)
clandon_img_file_two = URI.open('https://historicengland.org.uk/etl/1015781/5cd574d0-bb2a-496b-a244-4a3931482917.jpg')
clandon_img.photo.attach(io: clandon_img_file_two, filename: "lith.jpg", content_type: 'image/png')
clandon_img.save

trip = Trip.create(name: "Marvel at the Cross and Hand Stone", tagline: "Pillar with Stunning Lichen", description: "Let's see the stone and then head to the pub")
TripUser.create(trip: trip, user: brian)
TripUser.create(trip: trip, user: gertrude)
stone = Megalith.find_by_name('Cross and Hand Stone')
TripMegalith.create(trip: trip, megalith: stone, main: true)

p 'david trips'
make_trips(david)

p 'david ratings/comments/upvotes'
make_ratings_and_comments_and_upvotes(david)
p 'peter ratings/comments/upvotes'
make_ratings_and_comments_and_upvotes(peter)
p 'gertrude ratings/comments/upvotes'
make_ratings_and_comments_and_upvotes(gertrude)
p 'photo admin ratings/comments/upvotes'
make_ratings_and_comments_and_upvotes(@photoadmin)

p 'done'
