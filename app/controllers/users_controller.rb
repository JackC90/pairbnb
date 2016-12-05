class UsersController < ApplicationController
	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "Account created."
			redirect_to listings_path
		else
			flash[:alert] = "Error creating account."
			render "sign_up"
		end

		# respond_to do |format|
		# 	if @user.save
		# 		UserMailer.welcome_email(@user).deliver_later
		# 		format.html { redirect_to(@user, notice: "Account was successfully created.") }
		# 		format.json { render json: @user, status: created, location: @user }
		# 	else
		# 		format.html { render action: "new" }
		# 		format.json { render json: @user.errors, status: :unprocessable_entity }
		# 	end
		# end
	end

	def edit
		@user = current_user
	end

	def update
		@user = current_user
		@user.attributes = user_params
		if @user.save
			flash[:notice] = "Account is updated successfully."
			redirect_to listings_path
		else
			flash[:alert] = "Error in updating account."
			redirect_to edit_user_path(@user)
		end
	end

	def destroy
		@user = current_user
		@user.destroy
		redirect_to listings_path
	end

	private
	def user_params
		params.require(:user).permit(:email, :password)
	end
end
