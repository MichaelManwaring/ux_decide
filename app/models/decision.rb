class Decision < ActiveRecord::Base
	belongs_to :arbiter
	belongs_to :type
	has_one :firstoption
	has_one :secondoption
	has_many :votes, through: :firstoption
	has_many :votes, through: :secondoption


	def display_app_choice
		if self.app_choice == 0
			return self.firstoption.description
		elsif self.app_choice ==1 
			return self.secondoption.description
		else
			return "No choice made"
		end
	end
	def display_user_choice
		if self.user_choice == 0
			return self.firstoption.description
		elsif self.user_choice ==1 
			return self.secondoption.description
		else
			return "No choice made"
		end
	end
	
	def user_choice_assign(commit)
		if commit == "I took your advice"
			self.user_choice = self.app_choice
		elsif commit == "Actually, I'm going with the other one"
			if self.app_choice == 0
				self.user_choice = 1
			elsif self.app_choice == 1
				self.user_choice = 0
			else
				flash[:notice] = "bad commit"
			end
		end			
	end	

	def log_results_in_preference
		# update preference
	    @preference = self.arbiter.preferences.where(type: self.type).last
	    @preference.modify_preference(self.user_choice)
	end
	def name
		self.firstoption.description + " or " + self.secondoption.description
	end
	def find_preference
		self.arbiter.preferences.where(type: self.type).last
	end
end
