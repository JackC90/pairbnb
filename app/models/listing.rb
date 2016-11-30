class Listing < ApplicationRecord
	include Filterable
	belongs_to :user
	has_many :reservations
	has_one :amenity
	self.per_page = 12
	mount_uploaders :images, ImageUploader
	validates :date_begin, presence: true
	validates :date_end, presence: true, date: {after_or_equal_to: :date_begin, message: "End date must be after start date. Please choose another date." }
	validates :title, presence: true
	validates :description, presence: true
	validates :price, presence: true

	def all_bookings
		bookings = self.reservations.all
		i = 0
		day_list = Array.new
		while i < bookings.length do
			book_days = bookings[i].all_days
			day_list.concat(book_days)
			i += 1
		end
		day_list = day_list.uniq
		return day_list
	end 

	# Scopes for Searching
	scope :available, -> (availability) { where(availability: availability) }
	scope :starts_with, -> (title) { where("title ilike ?", "#{title}%")}
	scope :filter_location, -> (location) { where(location: "#{location}") }
	scope :price_above, -> (price) { where("price >= ?", price) }
	scope :price_below, -> (price) { where("price <= ?", price) }
	scope :bedrooms, -> (no_of_bedrooms) { where(no_of_bedrooms: no_of_bedrooms)}
	scope :bathrooms, -> (no_of_bathrooms) { where(no_of_bathrooms: no_of_bathrooms)}
	scope :capacity, -> (max) { where(max_occupants: max) }

	# Scopes for Searching with Amenities
	scope :has_pool, 			-> (bool) { joins(:amenity).where("amenities.pool = ?", bool) }
	scope :has_wifi, 			-> (bool) { joins(:amenity).where("amenities.wifi = ?", bool) }
	scope :has_gym, 			-> (bool) { joins(:amenity).where("amenities.gym = ?", bool) }
	scope :has_kitchen, 		-> (bool) { joins(:amenity).where("amenities.kitchen = ?", bool) }
	scope :has_golf_course, 	-> (bool) { joins(:amenity).where("amenities.golf_course = ?", bool) }
	scope :has_tennis_court, 	-> (bool) { joins(:amenity).where("amenities.tennis_court = ?", bool) }
end
