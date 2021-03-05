require 'json'

# # use only those liths for which we have a valid phot url
# v1 = JSON.parse(File.read('Devon-v1.json'))
# with_photos = v1.select { |_k, lith| lith.keys.include? 'imgurl' }
#                 .select { |_k, lith| lith['imgurl'].match /https:\/\/megalithic.co.uk\/a558\/.*/ }
# # File.write('Somerset-v2-filtered-with-photos.json', JSON.dump(with_photos))

# # convert lat long to usable format
# # with_photos = JSON.parse(File.read('Somerset-v2-filtered-with-photos.json'))
# lat_long_corrected = with_photos.map do |name, lith|
#   lith['latitude'].delete_prefix! 'Latitude: '
#   if lith['latitude'][-1] == 'N'
#     lith['latitude'] = lith['latitude'].to_f
#   elsif lith['latitude'][-1] == 'S'
#     lith['latitude'] = lith['latitude'].to_f * -1
#   else
#     p name
#   end
#   lith['longitude'].delete_prefix! 'Longitude: '
#   if lith['longitude'][-1] == 'E'
#     lith['longitude'] = lith['longitude'].to_f
#   elsif lith['longitude'][-1] == 'W'
#     lith['longitude'] = lith['longitude'].to_f * -1
#   else
#     p name
#   end
#   lith
# end
# File.write('Devon-v3-latlong-formatted.json', JSON.dump(lat_long_corrected))

# # with_imgurl = JSON.parse(File.read('Devon-v3-latlong-formatted.json'))
# all_urls = []
# lat_long_corrected.each do |lithhash|
#   all_urls << lithhash['imgurl']
# end
# puts all_urls.select { |url| url.match /https:\/\/megalithic.co.uk\/a558\/.*/ }
# p v1.size
# p all_urls.size
