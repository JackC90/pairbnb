class Listing < ApplicationRecord
	belongs_to :user
	has_many :reservations
	self.per_page = 12
	mount_uploaders :images, ImageUploader
	validates :date_begin, presence: true
	validates :date_end, presence: true, date: {after_or_equal_to: :date_begin, message: "End date must be after start date. Please choose another date." }
	validates :title, presence: true
	validates :description, presence: true
	validates :price, presence: true

end
