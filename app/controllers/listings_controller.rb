class ListingsController < ApplicationController
	def index
		@listings 	= Listing.order("created_at DESC").page(params[:page])
	end

	def show
	end

	def edit
	end

	def delete
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
