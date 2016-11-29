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

	def owner?(listing)
		if listing.user == current_user || current_user.admin?
			true
		else
			false
		end
	end

	def hide_link(listing)
		if owner?(listing)
			return ""
		else
			return "display:none"
		end
	end
end

