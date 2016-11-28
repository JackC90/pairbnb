class ReservationsController < ApplicationController
	def create
		@listing = Listing.find(params[:listing_id])
		@reservation = @listing.reservations.new(reservation_params.merge({user_id: current_user.id}))
		if @reservation.save 
			redirect_to listing_path(@listing)
			ReservationMailer.booking_email(current_user, @listing.user, @reservation.id).deliver
			format.html { redirect_to @user, notice: "Booking has been successfully made." }
			format.json { render :show, status: :created, location: @reservation }
		else
			format.html { render :new }
			format.json { rener json: @reservation.errors, status: :unprocessable_entity }
		end
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
