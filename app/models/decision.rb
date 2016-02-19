class Decision < ActiveRecord::Base
	belongs_to :user
	TYPEDESC = ["This or That", "Cheap or Expensive", "Healthy or Indulge", "Easy or Hard", "Safe or Risky", "Adventure or Relax", "Custom"]
	def decision_type
		TYPEDESC[self.dec_type]
	end
	def self.type_index(type_text)
		TYPEDESC.index(type_text)
	end
	def app_result
		if self.dec_type == 6
			if self.app_choice == 0
				return self.option_a
			elsif self.app_choice == 1
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
	def user_result
		if self.dec_type == 6
			if self.user_choice == 0
				return self.option_a
			elsif self.user_choice == 1
				return self.option_b
			else
				return "User has not answered"
			end
		else
			if self.user_choice == 0
				return self.decision_type.split()[0]
			elsif self.user_choice == 1
				return self.decision_type.split()[2]
			else
				return "User has not answered"
			end
		end	
	end
	def return_a
		if self.dec_type == 6
			return self.option_a
		else
			return self.decision_type.split()[0]
		end	
	end	
	def return_b
		if self.dec_type == 6
			return self.option_b
		else
			return self.decision_type.split()[2]
		end	
	end
	def voter_result
		if self.a_count > self.b_count
			return self.decision_type.split()[0]
		elsif self.a_count < self.b_count
			return self.decision_type.split()[2]
		else
			return "too close to call!"
		end		
	end
end
