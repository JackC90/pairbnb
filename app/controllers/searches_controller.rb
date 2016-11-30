class SearchesController < ApplicationController
	include Filterable
	def filter
		# @listings = Listing.filter(params.slice(:price_above, :price_below, :bedrooms, :bathrooms, :capacity))
		@listings = Listing.filter(params[:search])
		@listings = @listings.order("created_at DESC").page(params[:page])
		render template:"listings/index"
	end
end
