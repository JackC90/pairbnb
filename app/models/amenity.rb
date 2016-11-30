class Amenity < ApplicationRecord
	include Filterable
	belongs_to :listing
	scope :has_pool, 			-> (bool) { where(pool: bool) }
	scope :has_wifi, 			-> (bool) { where(wifi: bool) }
	scope :has_gym, 			-> (bool) { where(gym: bool) }
	scope :has_kitchen, 		-> (bool) { where(kitchen: bool) }
	scope :has_golf_course, 	-> (bool) { where(golf_course: bool) }
	scope :has_tennis_court, 	-> (bool) { where(tennis_court: bool) }
end
