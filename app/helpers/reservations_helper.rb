module ReservationsHelper
	def paid?(booking)
		Payment.exists?(reservation_id: booking.id)
	end

	def hide_if_paid(booking)
		if paid?(booking)
			return "display:none"
		else
			return ""
		end
	end

	def show_if_paid(booking)
		if paid?(booking)
			return ""
		else
			return "display:none"
		end
	end

	def all_days(booking)
		d_in 	= booking.date_in
		d_out 	= booking.date_out 
		days 	= Array.new
		while d_in <= d_out do
			days << d_in.strftime("%Y-%m-%d")
			d_in += 1
		end
		return days
	end

	def all_bookings(listing)
		bookings = listing.reservations.all
		i = 0
		day_list = Array.new
		while i < bookings.length do
			book_days = all_days(bookings[0])
			day_list.concat(book_days)
			i += 1
		end
		day_list = day_list.uniq
		return day_list
	end 
end
