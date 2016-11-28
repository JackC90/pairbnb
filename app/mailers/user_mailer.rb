class UserMailer < ApplicationMailer
	default from: 'notifications@example'

	def welcome_email(user)
		@user = user
		@url = url_for(@user)
		mail(to: @user.email, subject: "Welcome to PairBnB")
	end
end
