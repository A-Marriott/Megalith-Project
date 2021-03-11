stone = Megalith.where(name: 'Cross and Hand Stone').first

trip = stone.trips.first

trip.update(date_visited: nil, published: false, top_tip: nil, tagline: nil, description: "let's see this rock and then have a few pints")

trip.trip_photos.each {|p| p.destroy}

brian = User.first

badbury = Megalith.find_by_name('Badbury Rings')

visited = Visited.where(user: brian, megalith: badbury).first

visited.destroy
