class Listing < ApplicationRecord
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
	scope :starts_with, -> (name) { where("name like ?", "#{name}%")}
	scope :location, -> (location) { where(location: "#{location}") }
	scope :price_above, -> (price) { where("price >= ?", price) }
	scope :price_below, -> (price) { where("price <= ?", price) }
end
