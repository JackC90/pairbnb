class ProfilesController < ApplicationController
	def new
		@user = current_user if !current_user.nil?
	end

	def create
		@profile = current_user.build_profile(profile_params)
		if @profile.save
			redirect_to user_profile_path(@profile.user, @profile)
		else
			render "new"
		end
	end

	def show
		@user = User.find(params[:user_id])
		@profile = @user.profile
	end

	def edit
		@user = current_user
		@profile = @user.profile
	end

	def update
		@user = User.find(params[:user_id])
		@profile = @user.profile
		if @user.id == current_user.id
			if @profile.update(profile_params)
				redirect_to user_profile_path(@profile.user, @profile)
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
