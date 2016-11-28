class ReservationMailer < ApplicationMailer
	default from: "pairbnb90123@gmail.com"

	def booking_email(customer, host, reservation_id)
		@customer = customer
		@host = host
		@reservation = Reservation.find(reservation_id)
		@listing = @reservation.listing
		@url = url_for([@listing, @reservation])
		mail(to: @host.email, subject: "PairBnB Reservation" )
	end

end
