module Filterable
	extend ActiveSupport::Concern

	module ClassMethods
		
		def filter(filtering_params)
			results = self.where(nil)
			filtering_params.each { |key, value|
				results = results.send(key, value) if value.present?
			}
			results
		end
	end
end


