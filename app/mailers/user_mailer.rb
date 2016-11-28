class UserMailer < ApplicationMailer
	default from: 'notifications@example'

	def welcome_email(user)
		@user = user
		@url = 'http://example.com/login'
		mail(to: @user.email, subject: "Welcome to PairBnB")
	end
end
