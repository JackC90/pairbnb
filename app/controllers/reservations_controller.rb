class ReservationsController < ApplicationController
	def create
		@listing = Listing.find(params[:listing_id])
		@reservation = @listing.reservations.new(reservation_params.merge({user_id: current_user.id}))
		@reservation.save 
		redirect_to listing_path(@listing)
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
