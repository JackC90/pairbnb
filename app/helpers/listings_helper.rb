module ListingsHelper
	def to_RM(price)
		number_to_currency(price, unit: "RM")
	end

	def show_availability(listing)
		if listing.availability
			"Available"
		else
			"Not Available"
		end
	end
end
