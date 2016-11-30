class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  	def to_bool(str)
		values = ["true", true, 1, "1"]
		values.include?(str)
	end
end
