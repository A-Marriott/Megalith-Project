stone = Megalith.find_by_name('Cross and Hand Stone')
trip = stone.trips.first
trip.update(date_visited: nil, published: false, top_tip: nil, tagline: nil, description: "let's see this rock and then have a few pints")
stone.megalith_photos.select {|p| p.photo_key }.each {|p| p.destroy}
trip.trip_photos.each {|p| p.destroy}

visited1 = Visited.where(user: brian, megalith: stone).first
visited1.destroy

rating = Rating.where(user: brian, megalith: stone).first
rating.destroy

brian = User.first
badbury = Megalith.find_by_name('Badbury Rings')
badbury.trips.last.destroy
badbury.megalith_photos.first.disliked_by brian
visited2 = Visited.where(user: brian, megalith: badbury).first
visited2.destroy


badbury = Megalith.find_by_name('badbury rings')
badbury.megalith_photos.first.get_likes.last.destroy
