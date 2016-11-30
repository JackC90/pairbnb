class Amenity < ApplicationRecord
	include Filterable
	belongs_to :listing
	
end
