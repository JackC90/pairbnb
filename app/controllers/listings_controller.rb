class ListingsController < ApplicationController
	def new
		@listing = Listing.new(user_id: current_user.id)
	end

	def create
		@user = current_user
		@listing = @user.listings.new(listing_params)
		if @listing.save
			redirect_to @listing
		else
			render "new"
		end
	end

	def index
		@listings 	= Listing.order("created_at DESC").page(params[:page])
	end

	def show
		@listing = Listing.find(params[:id])
		@amenity = @listing.amenity
	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def update
		@listing = Listing.find(params[:id])
		if current_user.admin? || current_user == @listing.user
			if @listing.update(listing_params)
				redirect_to listing_path(@listing)
			else
				render "edit"
			end
		else
			redirect_to listings_path, notice: "Sorry, you have to be an admin to edit listing."
		end
	end

	def destroy
		if current_user.admin?
			@listing = Listing.find(params[:id])
			@listing.destroy
			redirect_to listings_path
		else
			redirect_to listings_path, notice: "Sorry, you have to be an admin to delete listing."
		end
	end

	private
	def listing_params
		params.require(:listing).permit(
			:title,
			:location,
			:address,
			:price,
			:description,
			:date_begin,
			:date_end,
			:availability,
			:max_occupants,
			:no_of_bedrooms,
			:no_of_bathrooms,
			{:images => []}
		)
	end
end
