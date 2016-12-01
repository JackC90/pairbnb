module ApplicationHelper
	def format_date(date)
		date.strftime("%d %B %Y")
	end

	def hide_if_none(listings)
		listings.nil? || listings == [] ? "display:none" : ""
	end
	
	def check_profile_exists
		if !current_user.nil?
			if Profile.exists?(user_id: current_user.id)
				return true
			else
				return false
			end
		else
			return false
		end
	end
end
