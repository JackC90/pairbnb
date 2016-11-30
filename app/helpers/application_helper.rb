module ApplicationHelper
	def format_date(date)
		date.strftime("%d %B %Y")
	end

	def hide_if_none(listings)
		listings.nil? ? "display:none" : ""
	end
	
end
