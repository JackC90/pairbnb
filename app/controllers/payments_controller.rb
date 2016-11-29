class PaymentsController < ApplicationController
	def new
		@token = Braintree::ClientToken.generate
		@reservation = Reservation.find(params[:reservation_id])
	end


	def create
		@reservation = Reservation.find(params[:reservation_id])
		amount = payment_params[:amount]
		nonce_from_the_client = payment_params[:payment_method_nonce]
		result = Braintree::Transaction.sale(
		  :amount => amount,
		  :payment_method_nonce => nonce_from_the_client,
		  :options => {
		    :submit_for_settlement => true
		  }
		)
		@payment = @reservation.payments.new(amount: amount)
		@payment.save
		redirect_to(listing_reservation_payment_path(@reservation.listing, @reservation, @payment))
	end

	def show
		@payment = Payment.find(params[:id])
		@reservation = @payment.reservation	
	end

	def payment_params
		params.require(:payment).permit(
			:amount,
			:payment_method_nonce
		)
	end
end
