class Vote < ActiveRecord::Base
	belongs_to :arbiter
	belongs_to :firstoption
	belongs_to :secondoption

	def decision
	    self.firstoption ? self.firstoption.decision : self.secondoption.decision
	end
	def log_results_in_preference
		# update preference
	    @preference = self.arbiter.preferences.where(type: self.decision.type).last
	    self.firstoption ? @preference.modify_preference(0) : @preference.modify_preference(1)
	end
end
