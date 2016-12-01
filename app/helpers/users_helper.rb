module UsersHelper
	def show_if_own(model)
		model.user == current_user ? "" : "display:none"
	end
end
