class ListingsController < ApplicationController
	def index
		# @user 		= User.find(params[:user_id])
		@listings 	= Listing.all
	end

	private
	def listing_params
		params.require(:listing).permit(
			:user_id,
			:location,
			:address,
			:price,
			:description,
			:availability,
			:max_occupants,
			:no_of_bedrooms,
			:no_of_bathrooms)
	end
end
