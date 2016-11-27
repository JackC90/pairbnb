class ProfileController < ApplicationController
	def create
		@profile = current_user.profiles.new(profile_params)
		if @profile.save
			redirect_to @profile
		else
			render "new"
		end
	end

	def show
		@user = User.find(params[:user_id])
		@profile = @user.profiles.find(params[:id])
	end

	def edit
		@user = User.find(params[:user_id])
		@profile = @user.profiles.find(params[:id])
	end

	def update
		@user = User.find(params[:user_id])
		if @user.id == current_user.id
			if @profile.update(profile_params)
				redirect_to @profile
			else
				render "edit"
			end
		end
	end

	private
	def profile_params
		params.require(:profile).permit(
			:name,
			:location,
			:country,
			:description,
			:gender,
			:birthdate,
			:phone,
			:email,
			:language,
			:currency,
			:school,
			:work,
			:address,
			:avatar)
	end
end
