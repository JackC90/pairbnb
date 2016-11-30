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

	def days_between(date_in, date_out)
		d_in 	= date_in
		d_out 	= date_out 
		days 	= Array.new
		while d_in <= d_out do
			days << d_in.strftime("%Y-%m-%d")
			d_in += 1
		end
		days
	end
end
