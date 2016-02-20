class Type < ActiveRecord::Base
	has_many :decisions
	has_many :preferences
	def possibility_name(a_or_b)
		if a_or_b == 0
			self.description.split()[0]
		elsif a_or_b == 1
			self.description.split()[2]
		else
			"invalid possibility request"
		end
	end
end
