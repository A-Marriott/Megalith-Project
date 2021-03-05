require 'json'
require 'open-uri'

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

p 'deleting users and liths'
MegalithPhoto.destroy_all
User.destroy_all
Megalith.destroy_all
p 'some new ones:'

brian = User.create(email: 'brian@internet.com', password: 'password', username: 'Brian LithLegend')
noobles = User.create(email: 'rocknoob@test.com', password: 'password', username: 'Noob on the Rocks')
photoadmin = User.create(email: 'photographer@test.com', password: 'password', username: 'Stone cold Snapper')

json_file = File.join(File.dirname(__FILE__), "./seed-play/Dorset-v3-latlong-formatted.json")
liths = JSON.parse(File.read(json_file))
# load 20 with photos
liths.first(20).each { |lith| load_lith_with_photo(lith) }

p 'done'
