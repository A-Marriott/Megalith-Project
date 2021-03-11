stone = Megalith.where(name: 'Cross and Hand Stone').first

trip = stone.trips.first

trip.update(date_visited: nil, published: false)
