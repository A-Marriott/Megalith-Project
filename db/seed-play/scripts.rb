require 'json'

# # use only those liths for which we have a phot url
# check if imgurl contains geograph,if so drop it
# v1 = JSON.parse(File.read('Dorset-v1.json'))
# with_photos = v1.select { |_k, lith| lith.keys.include? 'imgurl' }
# File.write('Dorset-with-photos.json', JSON.dump(with_photos))

# # convert lat long to usable format
# with_photos = JSON.parse(File.read('Dorset-with-photos.json'))
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
# File.write('Dorset-latlong.json', JSON.dump(lat_long_corrected))
