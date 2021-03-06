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
  img.user = photoadmin
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
TripPhoto.destroy_all
MegalithPhoto.destroy_all
Trip.destroy_all
User.destroy_all
Megalith.destroy_all
p 'some new ones:'

brian = User.create(email: 'brian@internet.com', password: 'password', username: 'Brian LithLegend')
noobles = User.create(email: 'rocknoob@test.com', password: 'password', username: 'Noob on the Rocks')
david = User.create(email: 'david@test.com', password: 'password', username: 'David Stone Man')
peter = User.create(email: 'peter@internet.com', password: 'password', username: 'Peat ;)')
gertrude = User.create(email: 'gertrude@internet.com', password: 'password', username: 'Gertie')
photoadmin = User.create(email: 'photographer@test.com', password: 'password', username: 'Stone cold Snapper')

dorset_file_relative = "./seed-play/Dorset-v3-latlong-formatted.json"
devon_file_relative = "./seed-play/Devon-v3-latlong-formatted.json"
somerset_file_relative = "./seed-play/Somerset-v3-latlong-formatted.json"
all_three = [dorset_file_relative, devon_file_relative, somerset_file_relative]
def hash_of_liths_from_json(relative_filepath)
  json_file = File.join(File.dirname(__FILE__), relative_filepath)
  liths = JSON.parse(File.read(json_file))
end
# # # OPTIONS --- PICK ONE ONLY
# 1 load 20 with photos
# hash_of_liths_from_json(dorset_file_relative).first(20).each { |lith| load_lith_with_photo(lith) }

# 2 load all with photos - expensive for cloudinary, will take a long time
# all_three.each do |filepath|
#   hash_of_liths_from_json(filepath).each { |lith| load_lith_with_photo(lith) }
# end

# 3 load all without photos - good to practise with pagination and lots of stuff on the map
# all_three.each do |filepath|
#   hash_of_liths_from_json(filepath).each { |lith| load_lith_without_photo(lith) }
# end

# 4 load somerset with photos and devon/dorset without - maybe a good balance for the final presentation?
# hash_of_liths_from_json(somerset_file_relative).each { |lith| load_lith_with_photo(lith) }
# hash_of_liths_from_json(devon_file_relative).each { |lith| load_lith_without_photo(lith) }
# hash_of_liths_from_json(dorset_file_relative).each { |lith| load_lith_without_photo(lith) }

# 5 load somerset with photos and devon/dorset with fakes
# hash_of_liths_from_json(somerset_file_relative).each { |lith| load_lith_with_photo(lith) }
# hash_of_liths_from_json(devon_file_relative).each { |lith| load_lith_with_fake_photo(lith) }
# hash_of_liths_from_json(dorset_file_relative).each { |lith| load_lith_with_fake_photo(lith) }

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

p 'done'
