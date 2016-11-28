class UsersController < ApplicationController
	def create
		@user = User.new(user_params)
		redirect_to listing_path(@user)

		respond_to do |format|
			if @user.save
				UserMailer.welcome_email(@user).deliver_later
				format.html { redirect_to(@user, notice: "Account was successfully created.") }
				format.json { render json: @user, status: created, location: @user }
			else
				format.html { render action: "new" }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end


	private
	def user_params
		params.require(:user).permit(:email, :password)
	end
end
