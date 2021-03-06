# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users
def generate_users
	num = (0..24).to_a
	users = num.map {|n| "user" + n.to_s}
	emails = users.map {|e| e + "@mail.com" }

	num.each{ |n| User.create(email: emails[n], password: "123456") }
end

def generate_listings
	# Listings
	
	75.times {
		listings.create(
			user_id: User.find_by(email: "user#{rand(0..24)}@mail.com").id,
			location: FFaker::Address.city,
			title: FFaker::Venue.name,
			address: FFaker::Address.street_address,
			price: rand(100.00..100_000.00).round(2),
			description: FFaker::CheesyLingo.sentence,
			availability: true,
			max_occupants: rand(1..8),
			no_of_bedrooms: rand(1..4),
			no_of_bathrooms: rand(1..4)
			)
	}
end

def generate_admin
	# Admin
	User.find_by(email: "user0@mail.com").update(role: 2)
end

# Amenities
def generate_amenities
	listings = Listing.all
	listings.each{ |listing| 
		listing.create_amenity(
			pool: [true, false].sample,
			wifi: [true, false].sample,
			gym: [true, false].sample,
			kitchen: [true, false].sample,
			golf_course: [true, false].sample,
			tennis_court: [true, false].sample
	) }
end

generate_users
generate_listings
generate_admin
generate_amenities