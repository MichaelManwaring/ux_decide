class Decision < ActiveRecord::Base
	belongs_to :user
	TYPEDESC = ["Expensive vs. Cheap", "Healthy vs. Treat", "Hard vs. Easy", "Light vs. Dark", "Left vs. Right", "This vs. That", "Custom"]
	def decision_type
		TYPEDESC[self.dec_type]
	end
	def self.type_index(type_text)
		TYPEDESC.index(type_text)
	end
	def specified_result
		if self.dec_type == 6
			if self.app_choice = 0
				return self.option_a
			elsif self.app_choice = 1
				return self.option_b
			else
				return "No Decision"
			end
		else
			if self.app_choice = 0
				return self.decision_type.split()[0]
			elsif self.app_choice = 1
				return self.decision_type.split()[2]
			else
				return "No Decision"
			end
		end	
	end
end
