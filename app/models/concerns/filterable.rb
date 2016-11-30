module Filterable
	extend ActiveSupport::Concern

	module ClassMethods
		
		def filter(filter_params)
			results = self.all
			filtering_params.each { |key, value|
				results = results.public_send(key, value) if value.present?
			}
		end
		
	end
end


