class UsersController < ApplicationController
	def create
		@user = User.new(user_params)
		redirect_to listing_path(@user)
	end

	private
	def user_params
		params.require(:user).permit(:email, :password)
	end
end
