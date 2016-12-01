class ReservationsController < ApplicationController
	def create
		@listing = Listing.find(params[:listing_id])
		@reservation = @listing.reservations.new(reservation_params.merge({user_id: current_user.id, listing_id: @listing.id}))
		total_price = @listing.price * @reservation.all_days.length
		@reservation.total_price = total_price

		if @reservation.save 
			ReservationJob.perform_later(current_user, @listing.user, @reservation.id)
			# # format.html
			# # flash[:success] = "Booking has been successfully made."
			redirect_to(listing_reservation_path(@listing, @reservation))
		else
			# flash[:error] = "Booking has not been made. Try again."
			redirect_to listing_path(@listing)
		end
	end

	def show
		@listing = Listing.find(params[:listing_id])
		@reservation = Reservation.find(params[:id])
	end

	def update
	end

	def destroy
	end

	private
	def reservation_params
		params.require(:reservation).permit(
			:date_in,
			:date_out,
			:no_of_guests,
			:total_price
		)
	end 
end
