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

end
