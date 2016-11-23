class Listing < ApplicationRecord
	belongs_to :user
	self.per_page = 12
end
